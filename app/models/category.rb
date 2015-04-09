class Category < ActiveRecord::Base
  STATUS = %w(0, 1)

  has_many :words, dependent: :destroy

  validates :name, length: {minimum: 3, maximum:20}
  validates :name, presence: true
end
