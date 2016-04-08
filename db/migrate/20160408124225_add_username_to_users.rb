class AddUsernameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_column :users, :nickname, :string
    add_column :users, :phone, :string
  end
end
