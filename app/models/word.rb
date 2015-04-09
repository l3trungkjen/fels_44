class Word < ActiveRecord::Base
  belongs_to :category
  has_many :answers, inverse_of: :word

  accepts_nested_attributes_for :answers, allow_destroy: true

  validates :category_id, presence: true
  validates :name, length: {minimum: 1, maximum:20}, presence: true
  validates :mean, length: {minimum: 1, maximum:20}, presence: true
end