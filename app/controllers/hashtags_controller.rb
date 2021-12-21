class HashtagsController < ApplicationController
  def show
    @hashtag = Hashtag.with_questions.find_by!(text: params[:text])
    @questions = @hashtag.questions.sorted  
  rescue ActiveRecord::RecordNotFound
    render_not_found
  end
end
