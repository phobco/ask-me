require 'uri'

class User < ApplicationRecord
  ITERATIONS = 20_000
  DIGEST = OpenSSL::Digest::SHA256.new
  USERNAME_VALIDATION_REGEX = /\A[\w]+\z/

  attr_accessor :password

  has_many :questions

  validates :email, :username, presence: true
  validates :email, :username, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  
  validates :password, presence: true, on: :create
  validates :password, confirmation: true

  validates :username, length: { maximum: 40 }
  validates :username,format: { with: USERNAME_VALIDATION_REGEX }

  before_validation :username_downcase
  before_save :encrypt_password

  def self.authenticate(email, password)
    user = find_by(email: email)

    return unless user.present?

    hashed_password = User.hash_to_string(
      OpenSSL::PKCS5.pbkdf2_hmac(
        password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST
      )
    )

    user if user.password_hash == hashed_password
  end

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  private

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

  def username_downcase
    return unless username.present?

    self.username = username.downcase
  end
end
