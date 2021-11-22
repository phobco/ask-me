class User < ApplicationRecord
  ITERATIONS = 20_000
  DIGEST = OpenSSL::Digest::SHA256.new
  USERNAME_VALIDATION_REGEX = /\A\w+\z/
  HEX_VALIDATION_REGEX = /\A#\h{3}{1,2}\z/

  attr_accessor :password

  has_many :questions, dependent: :destroy

  validates :email, :username, presence: true
  validates :email, :username, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  
  validates :password, presence: true, on: :create
  validates :password, confirmation: true

  validates :username, length: { maximum: 40 }, format: { with: USERNAME_VALIDATION_REGEX }
  validates :background_color, format: { with: HEX_VALIDATION_REGEX }
  validates :avatar_url, url: { allow_nil: true, allow_blank: true }

  before_validation :username_downcase, :email_downcase
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
    username&.downcase!   
  end

  def email_downcase
    email&.downcase!   
  end
end
