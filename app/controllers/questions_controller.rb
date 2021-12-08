class QuestionsController < ApplicationController
  before_action :load_question, only: [:show, :edit, :update, :destroy]
  before_action :authorise_user, except: [:create]
  
  def edit
  end

  def create
    @question = Question.new(question_params)
    @question.author_id = current_user.id if current_user

    if check_captcha(@question) && @question.save
      redirect_to user_path(@question.user), notice: 'Вопрос задан'
    else
      render :edit
    end
  end

  def update
    if @question.update(question_params)
      redirect_to user_path(@question.user), notice: 'Вопрос сохранён'
    else
      render :edit
    end
  end

  def destroy
    user = @question.user
    @question.destroy

    redirect_to user_path(user), notice: 'Вопрос удалён'
  end

  private

  def load_question
    @question = Question.find(params[:id])
  end
  
  def authorise_user
    reject_user unless @question.user == current_user
  end

  def question_params
    if current_user.present? && params[:question][:user_id].to_i == current_user.id
      params.require(:question).permit(:user_id, :text, :answer)
    else
      params.require(:question).permit(:user_id, :text)
    end
  end

  def check_captcha(model)
    current_user.present? || verify_recaptcha(model: model)
  end
end
