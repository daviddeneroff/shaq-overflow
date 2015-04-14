class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  belongs_to :question
  belongs_to :answer
  has_many :votes, as: :votable
  has_many :users, through: :votes

  def c_net
    self.votes.where(value: 1).count - self.votes.where(value: -1).count
  end

end
