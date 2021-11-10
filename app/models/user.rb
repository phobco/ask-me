require 'openssl'

class User < ApplicationRecord
  ITERATIONS = 20_000
  DIGEST = OpenSSL::Digest::SHA256.new

  attr_accessor :password

  has_many :questions

  validates :email, :username, presence: true
  validates :email, :username, uniqueness: true
  
  validates :password, presence: true, on: :create

  # ДЗ
  #
  # 1. Проверка формата электронной почты пользователя (гем 'valid_email2')
  validates :email, 'valid_email_2/email': { message: "is not a valid email" }

  # 2. Проверка максимальной длины юзернейма пользователя (не больше 40 символов)
  validates :username, length: { maximum: 40 }

  # 3. Проверка формата юзернейма пользователя (только латинские буквы, цифры, и знак _)
  validates :username,
    format: { with: /\A[a-zA-Z\d_]+\z/, message: "only Latin letters, numbers, and sign _" }

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
