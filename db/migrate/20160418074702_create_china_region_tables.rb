class CreateChinaRegionTables < ActiveRecord::Migration
  def change
    # create table provinces
    unless table_exists? 'provinces'
      create_table :provinces do |t|
        t.string :reference_id
        t.string :name
        t.timestamps
      end

      add_index :provinces, :reference_id
      add_index :provinces, :name
    end

    # create table cities
    unless table_exists? 'cities'
      create_table :cities do |t|
        t.string :reference_id
        t.string :name
        t.integer :province_id
        t.integer :level
        t.string :zip_code
        t.timestamps
      end
      add_index :cities, :reference_id
      add_index :cities, :name
      add_index :cities, :province_id
      add_index :cities, :level
      add_index :cities, :zip_code
    end

    # create table districts
    unless table_exists? 'districts'
      create_table :districts do |t|
        t.string :reference_id
        t.string :name
        t.integer :city_id
        t.timestamps
      end
      add_index :districts, :reference_id
      add_index :districts, :name
      add_index :districts, :city_id
    end

    # create table streets
    unless table_exists? 'streets'
      create_table :streets do |t|
        t.string :reference_id
        t.string :name
        t.integer :district_id
        t.timestamps
      end
      add_index :streets, :reference_id
      add_index :streets, :name
      add_index :streets, :district_id
    end
  end
end
