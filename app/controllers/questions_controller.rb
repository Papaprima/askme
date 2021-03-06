class QuestionsController < ApplicationController
  before_action :load_question, only: [:edit, :update, :destroy]
  before_action :authorize_user, except: [:create]

  def edit
  end


  def create
    @question = Question.new(question_params)

    if @question.save
      find_and_save_hashtags(@question.text)

      redirect_to user_path(@question.user), notice: 'Вопрос задан'
    else
      render :edit
    end
  end

  def update
    if @question.update(question_params)
      redirect_to user_path(@question.user), notice: 'Вопрос сохранен'
    else
      render :edit
    end
  end

  def destroy
    user = @question.user

    @question.destroy

    redirect_to user_path(user), notice: 'Вопрос удален :('
  end

  private

  def authorize_user
    reject_user unless @question.user == current_user
  end

  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    return params.require(:question).permit(:user_id, :text) if current_user.blank?

    return params.require(:question).permit(:user_id, :text, :answer) if params[:question][:user_id].to_i == current_user.id

    if params[:author_id].present?
      params.require(:question).permit(:user_id, :text).merge({author_id: params[:author_id].to_i})
    else
      params.require(:question).permit(:user_id, :text)
    end
  end

  def find_and_save_hashtags(question, answer = nil)
    question_hashtags = find_hashtags(question)

    if question_hashtags.present?
      question_hashtags.each do |h|
        hashtag = Hashtag.find_or_create_by(text: h.downcase)
        QuestionHashtag.create(question: @question, hashtag: hashtag)
      end
    end

    answer_hashtags = find_hashtags(answer) if answer.present?
    answer_hashtags.each { |h| Hashtag.find_or_create_by(text: h.downcase) } if answer_hashtags.present?
  end

  def find_hashtags(text)
    return unless text =~ /#[[:alpha:]\d_-]+/i

    text.scan(/#[[:alpha:]\d_-]+/i).flatten
  end
end
