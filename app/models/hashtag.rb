class Hashtag < ApplicationRecord
  REGEX = /#[[:word:]-]+/

  has_many :question_hashtags, dependent: :destroy
  has_many :questions, through: :question_hashtags
  
  validates :text, presence: true

  scope :with_questions, -> { joins(:questions) }
end
