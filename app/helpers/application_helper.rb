module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.png'
    end
  end

  def count_answers
    @user.questions.count(&:answer)
  end

  def unanswered_questions
    @questions.size - count_answers
  end
end
