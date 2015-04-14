class User < ActiveRecord::Base
  has_secure_password
  has_many :questions
  has_many :answers
  has_many :votes
  has_many :comments
  validates :username, :email, :password_digest, presence: true
  validates :username, :email, uniqueness: true
end
