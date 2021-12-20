class HashtagsController < ApplicationController
  def show
    @hashtag = Hashtag.find_by(text: params[:text])
    
    if @hashtag&.questions&.any?
      @questions = @hashtag.questions.sorted  
    else
      render_not_found
    end
  end
end
