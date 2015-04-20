class Word < ActiveRecord::Base
  belongs_to :category
  has_many :answers, inverse_of: :word
  has_many :lesson_words, inverse_of: :word

  accepts_nested_attributes_for :answers, allow_destroy: true
  accepts_nested_attributes_for :lesson_words, allow_destroy: true

  validates :category_id, presence: true
  validates :name, length: {minimum: 1, maximum:20}, presence: true
  validates :mean, length: {minimum: 1, maximum:20}, presence: true

  scope :random_with_number, ->number do
    where.not(id: LessonWord.select(:word_id)
    .where(answer: Answer.correct)).sample number
  end
end
