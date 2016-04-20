class User < ActiveRecord::Base
  rolify
  has_and_belongs_to_many :shops, :join_table => :shops_users
  mount_uploader :avatar, AvatarUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable, :timeoutable

  # Virtual attribute for authenticating by either username or email
  attr_accessor :login

  def avatar_url
    if self.avatar.url
      self.avatar.url(:large)
    else
      "/img/user4-128x128.jpg"
    end
  end

  class << self
    def find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions).where(["lower(username) = :value OR lower(email) = :value OR lower(phone) = :value", { value: login.downcase }]).first
      else
        where(conditions).first
      end
    end
  end
end
