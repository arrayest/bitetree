class CreateJoinTableUserShop < ActiveRecord::Migration
  def change
    create_join_table :users, :shops do |t|
      t.index [:user_id, :shop_id]
      t.index [:shop_id, :user_id]
    end
  end
end
