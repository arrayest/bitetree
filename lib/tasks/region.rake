require 'httparty'

namespace :region do

  desc 'Import china region fu'
  task :install do
    Rake::Task['db:migrate'].invoke
    Rake::Task['region:download'].invoke
    Rake::Task['region:import'].invoke
  end

  desc 'Download areas.json from https://raw.githubusercontent.com/saberma/china_city/master/db/areas.json'
  task :download do
    begin
      remote_url = 'https://raw.githubusercontent.com/saberma/china_city/master/db/areas.json'
      puts 'Downloading ...'
      # httparty gem
      File.open(Rails.root.join('config', 'areas.json'), 'wb') { |f| f.write(HTTParty.get(remote_url).body)}
      puts "Done! File located at: \e[32mconfig/areas.json\e[0m"
    rescue
      puts "\e[31mWarnning!!!\e[0m"
      puts "Download \e[33mareas.json\e[0m failed!"
      puts ''
      puts "You need download \e[33mareas.json\e[0m by hand from:"
      puts "\e[32mhttps://raw.githubusercontent.com/saberma/china_city/master/db/areas.json\e[0m"
    end
  end

  desc "Import region data to database from config/areas.json"
  task :import => :environment do
    puts 'Importing ...'
    # file_path = Rails.root.join('config', 'areas.json')
    # regions = JSON.parse(File.read(file_path))
    # load_to_db(regions)
    cleanup_regins
    load_china_city_to_db
    puts "Regions import done!"
  end

  def cleanup_regins
    binding.pry
    Province.delete_all
    City.delete_all
    District.delete_all
    Street.delete_all
  end

  def load_to_db(regions)
    regions["province"].each do |province|
      current_province = Province.where(name: province["text"], reference_id: province["id"]).first_or_create!
    end
    regions["city"].each do |city|
      current_city = City.where(name: city["text"], reference_id: city["id"]).first_or_create!
    end
    regions["district"].each do |district|
      current_district = Disrict.where(name: district["text"], reference_id: district["id"]).first_or_create!
    end
    regions["street"].each do |street|
      current_street = Street.where(name: street["text"], reference_id: street["id"]).first_or_create!
    end
  end

  def load_china_city_to_db
    ChinaCity.list.each do |province|
      current_province = Province.where(name: province.first, reference_id: province.last).first_or_create!
      ChinaCity.list(province.last).each do |city|
        current_city = City.where(name: city.first, reference_id: city.last, province_id: current_province).first_or_create!
        ChinaCity.list(city.last).each do |district|
          current_district = District.where(name: district.first, reference_id: district.last, city_id: current_city).first_or_create!
          ChinaCity.list(district.last).each do |street|
            current_street = Street.where(name: street.first, reference_id: street.last, district_id: current_district).first_or_create!
          end
        end
      end
    end
  end

end
