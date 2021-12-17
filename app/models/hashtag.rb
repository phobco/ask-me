class Hashtag < ApplicationRecord
  has_many :question_hashtags
  has_many :questions, through: :question_hashtags
  
  validates :text, presence: true, uniqueness: true
end
