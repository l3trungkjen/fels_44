class LessonWord < ActiveRecord::Base
  belongs_to :lesson, inverse_of: :lesson_words
  belongs_to :word
  belongs_to :answer

  validates :lesson, presence: true
  validates :word_id, presence: true

  delegate :correct, to: :answer, allow_nil: false
end
