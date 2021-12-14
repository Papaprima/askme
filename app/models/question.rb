# frozen_string_literal: true

# == Schema Information
#
# Table name: questions
#
#  id         :int           not null, primary key
#  text       :string
#  answer     :string
#  user_id    :int
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Question < ActiveRecord::Base
  belongs_to :user
  belongs_to :author, class_name: "User", foreign_key: "author_id", optional: true
  validates :user, :text, presence: true
  validates :text, length: { maximum: 255 }
end
