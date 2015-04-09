class Answer < ActiveRecord::Base
  belongs_to :word, inverse_of: :answers

  validates :word, presence: true
  validates :name, length: {minimum: 1, maximum: 20}
  validates :name, presence: true
  validates :correct, presence: true
end
