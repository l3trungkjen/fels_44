class Lesson < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :lesson_words, inverse_of: :lesson, dependent: :destroy

  accepts_nested_attributes_for :lesson_words, allow_destroy: true

  validates :user_id, presence: true
  validates :category_id, presence: true

  before_save :total_lesson_result

  scope :filter_by_category, ->category_id {where category_id: category_id}

  def total_lesson_result
    self.result = correct_answer
  end

  def correct_answer
    lesson_words.select{|lesson_word| lesson_word.correct}.count
  end
end
