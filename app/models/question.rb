class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  has_many :question_hashtags
  has_many :hashtags, through: :question_hashtags

  validates :text, presence: true, length: { maximum: 255 }
end
