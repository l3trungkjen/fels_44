class User < ActiveRecord::Base
  ADMIN = %w(1 2)

  attr_accessor :remember_token

  validates :email, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}
  validates :email, length: {minimum: 6, maximum: 25}
  validates :email, presence: true
  validates :email, uniqueness: {case_sensitive: false}
  validates :fullname, length: {minimum: 6, maximum: 25}
  validates :fullname, presence: true
  validates :password, length: {minimum: 6, maximum: 25}, allow_blank: true
  validates :password, presence: true, allow_blank: true
  validates :password_confirmation, length: {minimum: 6, maximum: 25}, allow_blank: true
  validates :password_confirmation, presence: true, allow_blank: true

  before_save :set_default

  has_secure_password

  def set_default
    self.email = email.downcase
    self.status = ADMIN.first
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create string, cost: cost
  end

  def remember
    self.remember_token = User.new_token
    update_attributes! remember_digest: User.digest(remember_token)
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attributes! remember_digest: nil
  end

end
