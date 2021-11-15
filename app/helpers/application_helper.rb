module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.png'
    end
  end

  def count_questions(number)
    if (number % 100).between?(11, 14)
      "#{number} вопросов"
    elsif number % 10 == 1
      "#{number} вопрос"
    elsif (number % 10).between?(2,4)
      "#{number} вопроса"
    else
      "#{number} вопросов"
    end
  end
end
