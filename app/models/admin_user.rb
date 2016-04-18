class AdminUser < User
  def self.default_scope
    Role.find_by(name: "admin").try(:users)
  end
end
