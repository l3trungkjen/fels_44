class User < ActiveRecord::Base
  ADMIN = %w(1 2)
  validates :fullname, :email, :password, :password_confirmation, presence: true
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: { case_sensitive: false }
  before_save :set_default
  has_secure_password

  def set_default
    self.email = email.downcase
    self.status = ADMIN.first
  end

end
