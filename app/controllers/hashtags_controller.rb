class HashtagsController < ApplicationController
  before_action :set_hashtag, only: [:show]

  def show
    @questions = @hashtag.questions.order(created_at: :desc)
  end

  private

  def set_hashtag
    @hashtag = Hashtag.find(params[:id])
  end
end
