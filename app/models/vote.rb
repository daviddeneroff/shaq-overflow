class Vote < ActiveRecord::Base
  belongs_to :votable, polymorphic: true
  belongs_to :user
  belongs_to :question
  belongs_to :comment
  belongs_to :answer
  # validates :user, uniqueness: { scope: [:votable_type, :votable_id], message: "User can only rate this once" }
  validates :votable_id, :votable_type, :user_id, :value, presence: true

end
