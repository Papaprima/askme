# frozen_string_literal: true

# == Schema Information
#
# Table name: question_hashtags
#
#  id           :int           not null, primary key
#  question_id  :int
#  hashtag_id   :int
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class QuestionHashtag < ActiveRecord::Base
  belongs_to :question
  belongs_to :hashtag
end
