class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  has_many :question_hashtags
  has_many :hashtags, through: :question_hashtags, dependent: :destroy

  after_save :create_hashtags
  after_commit :remove_hashtags_without_question

  validates :text, presence: true, length: { maximum: 255 }

  def create_hashtags
    self.hashtags = 
      "#{text} #{answer}".downcase.scan(/#[[:word:]-]+/).uniq.
      map { |hashtag| Hashtag.find_or_create_by(text: hashtag) }
  end

  def remove_hashtags_without_question
    Hashtag.includes(:questions).where(questions: { id: nil }).destroy_all
  end
end
