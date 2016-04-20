class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.string :name
      t.string :photo
      t.string :hotline
      t.string :area
      t.decimal :level
      t.boolean :verify
      t.string :address
      t.references :province
      t.references :city
      t.references :district
      t.references :street
      t.text :description

      t.timestamps null: false
    end
    add_index :shops, :province_id
    add_index :shops, :city_id
    add_index :shops, :district_id
    add_index :shops, :street_id
  end
end
