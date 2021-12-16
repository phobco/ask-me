class QuestionHashtag < ApplicationRecord
  belongs_to :question
  belongs_to :hashtag
end
