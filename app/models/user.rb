class User < ApplicationRecord
  has_many :posts

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :name,  presence: true, length: {maximum: Settings.max_name}
  validates :email, presence: true, length: {maximum: Settings.max_email},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: Settings.min_pass}, allow_nil: true

  before_save :email_downcase

  has_secure_password

  def email_downcase
    email.downcase!
  end
  
  def correct_user? user
    self == user
  end
end
