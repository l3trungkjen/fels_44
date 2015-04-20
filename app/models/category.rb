class Category < ActiveRecord::Base
  STATUS = %w(0, 1)

  has_many :words, dependent: :destroy
  has_many :lessons, dependent: :destroy
  has_many :users, through: :lessons

  validates :name, length: {minimum: 3, maximum:20}, presence: true
end
