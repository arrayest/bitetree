class Shop < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => :shops_users
end
