class User < ActiveRecord::Base
  has_secure_password
  has_many :questions
  has_many :answers
  has_many :votes
  has_many :comments
  validates :username, :email, :password_digest, presence: true
  validates :username, :email, uniqueness: true
end


def render_page()
statsd = Statsd.new
  p "3" * 1000
  p "we got another"
  statsd.increment('web.page_views')
  p "3" * 1000
end