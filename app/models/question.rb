class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  has_many :question_hashtags, dependent: :destroy
  has_many :hashtags, through: :question_hashtags

  after_save_commit :create_hashtags

  validates :text, presence: true, length: { maximum: 255 }

  scope :sorted, -> { order(created_at: :desc) }

  def create_hashtags
    self.hashtags = 
      "#{text} #{answer}".downcase.scan(Hashtag::REGEX).uniq.
      map { |hashtag| Hashtag.create_or_find_by(text: hashtag.delete('#')) }
  end
end
