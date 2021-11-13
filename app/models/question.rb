class Question < ApplicationRecord
  belongs_to :users

  validates :text, presence: true
  validates :text, length: { maximum: 255 }
end
