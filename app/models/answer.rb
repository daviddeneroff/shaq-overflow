class Answer < ActiveRecord::Base
  before_save :reset_chosen_answer

  belongs_to :user
  belongs_to :question
  has_many :comments, as: :commentable
  has_many :votes, as: :votable

  def reset_chosen_answer
    question = Question.find(self.question_id)
    question.reset_all_answers
  end

  def net
    self.votes.where(value: 1).count - self.votes.where(value: -1).count
  end

end
