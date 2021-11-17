class UsersController < ApplicationController

  before_action :load_user, except: [:index, :create, :new]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Данные обновлены'
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to root_url, notice: 'Пользователь успешно зарегистрирован!'
    else
      render 'new'
    end
  end

  def show
    @questions = @user.questions.order(created_at: :desc)

    @new_question = @user.questions.build

    @answers_number = @user.questions.count(&:answer)
    @unanswered_questions_number = @questions.size - @answers_number
  end

  private

  def load_user
    @user ||= User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :username, :avatar_url)
  end
end
