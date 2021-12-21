class UsersController < ApplicationController
  before_action :load_user, except: [:index, :create, :new]
  before_action :authorise_user, except: [:index, :new, :create, :show]

  def index
    @users = User.all
    @hashtags = Hashtag.with_questions.uniq
  end

  def new
    redirect_to root_url, alert: 'Вы уже залогинены' if current_user.present?

    @user = User.new
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Данные обновлены'
    else
      render :edit
    end
  end

  def create
    redirect_to root_url, alert: 'Вы уже залогинены' if current_user.present?

    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Добро пожаловать, #{@user.name}!"
    else
      render :new
    end
  end

  def show
    @questions = @user.questions.sorted

    @new_question = @user.questions.build

    @answers_number = @user.questions.count(&:answer)
    @unanswered_questions_number = @questions.size - @answers_number
  end

  def destroy
    if @user.id == current_user.id
      session[:user_id] = nil
      @user.destroy
    end

    redirect_to root_path, notice: 'Ваш аккаунт был удалён :('
  end

  private

  def authorise_user
    reject_user unless @user == current_user
  end

  def load_user
    @user ||= User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :username, :avatar_url, :background_color)
  end
end
