# coding: utf-8
class Street < ActiveRecord::Base
  if Rails.version < '4.0'
    attr_accessible :name, :district_id
  end

  belongs_to :district
  has_one :city , through: :district

  def short_name
    @short_name ||= name.gsub(/镇|街道/,'')
  end

  def brothers
    @brothers ||= Street.where("district_id = #{district_id}")
  end

end
