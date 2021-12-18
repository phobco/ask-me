class HashtagsController < ApplicationController
  def show
    @hashtag = Hashtag.find_by(text: params[:text])
    @questions = @hashtag.questions.sorted
  end
end
