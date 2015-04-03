class Word < ActiveRecord::Base
  belongs_to :category
  validates :category_id, :name, :mean, presence: true
end
