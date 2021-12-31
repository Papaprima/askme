# frozen_string_literal: true

# == Schema Information
#
# Table name: hashtags
#
#  id         :int           not null, primary key
#  text       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Hashtag < ActiveRecord::Base
  has_many :question_hashtags, dependent: :delete_all
  has_many :questions, through: :question_hashtags

  validates :text, presence: true
  validates :text, uniqueness: true
end
