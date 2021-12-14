# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id            :int           not null, primary key
#  name          :string
#  username      :string
#  email         :string
#  password_hash :string
#  password_salt :string
#  avatar_url    :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'openssl'

class User < ActiveRecord::Base
  # Параметры работы для модуля шифрования паролей
  ITERATIONS = 20_000
  DIGEST = OpenSSL::Digest::SHA256.new

  attr_accessor :password

  has_many :questions
  has_many :my_questions, class_name: 'Question', foreign_key: :author_id

  validates :email, :username, :email, presence: true
  validates :email, :username, uniqueness: true
  validates :password, presence: true, on: :create
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :username, length: { maximum: 40 }
  validates :username, format: { with: /\A[a-z0-9_]/i, on: :create }
  validates_confirmation_of :password

  before_save :encrypt_password

  def encrypt_password
    if password.present?
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(
          password, password_salt, ITERATIONS, DIGEST.length, DIGEST
        )
      )
    end
  end

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    user = find_by(email: email)

    return nil unless user.present?

    hashed_password = User.hash_to_string(
      OpenSSL::PKCS5.pbkdf2_hmac(
        password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST
      )
    )

    return user if user.password_hash == hashed_password

    nil
  end
end
