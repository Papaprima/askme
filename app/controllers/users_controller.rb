# frozen_string_literal: true

class UsersController < ApplicationController
  WORD_VERSION = %w[вопрос вопроса вопросов]

  def index
    @users = [
      User.new(
        id: 1,
        name: 'Vadim',
        username: 'installero',
        avatar_url: 'https://secure.gravatar.com/avatar/' \
          '71269686e0f757ddb4f73614f43ae445?s=100'
      ),
      User.new(id: 2, name: 'Misha', username: 'aristofun')
    ]
  end

  def new
  end

  def edit
  end

  def show
    @user = User.new(
      name: 'Vadim',
      username: 'installero',
      avatar_url: 'https://secure.gravatar.com/avatar/' \
        '71269686e0f757ddb4f73614f43ae445?s=100'
    )

    @questions = [
      Question.new(text: 'Как дела?', created_at: Date.parse('27.03.2016')),
      Question.new(
        text: 'В чем смысл жизни?', created_at: Date.parse('27.03.2016')
      )
    ]

    @right_version_word = right_version_word(@questions.count)

    @new_question = Question.new

  end

  private

  def right_version_word(questions_count)
    return WORD_VERSION[2] if (11..14).include?(questions_count % 100)

    case questions_count % 10
    when 1 then WORD_VERSION[0]
    when 2..4 then WORD_VERSION[1]
    else WORD_VERSION[2]
    end
  end
end
