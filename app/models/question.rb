class Question < ApplicationRecord
  validates :user, :text, presence: true
  
  validates :text, length: { maximum: 255 }
end
