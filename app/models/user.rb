class User < ActiveRecord::Base
  ADMIN = %w(1 2)

  attr_accessor :remember_token

  has_many :lessons, dependent: :destroy
  has_many :categories, through: :lessons
  has_many :active_relationships, class_name: "Relationship",
    foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
    foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

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
  validates :follower_id, presence: true
  validates :followed_id, presence: true

  before_save :set_default

  has_secure_password

  def set_default
    self.email = email.downcase
    self.status = ADMIN.first
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def User.digest string
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create string, cost: cost
  end

  def remember
    self.remember_token = User.new_token
    update_attributes! remember_digest: User.digest(remember_token)
  end

  def authenticated? remember_token
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attributes! remember_digest: nil
  end

  def follow other_user
    active_relationships.create followed_id: other_user.id
  end

  def unfollow other_user
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following? other_user
    following.include? other_user
  end

end
