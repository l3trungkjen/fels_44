class Answer < ActiveRecord::Base
  belongs_to :word, inverse_of: :answers
  has_many :lesson_words

  accepts_nested_attributes_for :lesson_words, allow_destroy: true

  validates :word, presence: true
  validates :name, length: {minimum: 1, maximum: 20}, presence: true
  validates :correct, presence: true

  scope :correct, ->{where correct: true}
end
