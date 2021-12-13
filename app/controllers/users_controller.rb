class UsersController < ApplicationController
  QUESTION_VERSION = %w[вопрос вопроса вопросов]
  ANSWER_VERSION = %w[ответ ответа ответов]
  UNANSWERED_VERSION = %w[безответный безответных безответных]

  before_action :load_user, except: %i[index create new]

  before_action :authorize_user, except: %i[index new create show]

  def index
    @users = User.all
  end

  def new
    redirect_to root_url, alert: 'Вы уже залогинены' if current_user.present?
    @user = User.new
  end

  def create
    redirect_to root_url, alert: 'Вы уже залогинены' if current_user.present?

    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: 'Пользователь успешно зарегестрирован!'
    else
      render 'new'
    end
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

  def show
    @questions = @user.questions.order(created_at: :desc)

    @new_question = @user.questions.build

    questions_count = @questions.count.presence || 0
    answers_count = @questions.where.not(answer: nil).count.presence || 0
    unanswered_count = questions_count - answers_count

    @questions_count_text = fetch_right_version_text(questions_count, QUESTION_VERSION)
    @answers_count_text = fetch_right_version_text(answers_count, ANSWER_VERSION)
    @unanswered_count_text = fetch_right_version_text(unanswered_count, UNANSWERED_VERSION)
  end

  def destroy
    session[:user_id] = nil
    @user.destroy
    redirect_to root_url, notice: 'Пользователь успешно удален!'
  end

  private

  def authorize_user
    reject_user unless @user == current_user
  end

  def load_user
    @user ||= User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 :name, :username, :avatar_url, :avatar_color_background)
  end

  def fetch_right_version_text(item_count, word_array)
    return word_array[2] if (11..14).include?(item_count % 100)

    right_version_word = case item_count % 10
                          when 1 then word_array[0]
                          when 2..4 then word_array[1]
                          else word_array[2]
                          end

    "<h1 class'title-small'>#{item_count}</h1><p>#{right_version_word}</p>"
  end
end
