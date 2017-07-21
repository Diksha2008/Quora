class Answer < ActiveRecord::Base
  validates :content, presence: true
  belongs_to :user
  belongs_to :question
  has_many :upvotes

  def upvoted_by user_id
  	Upvote.where(users_id: user_id, answer_id: id).first
  end
  def is_upvoted user_id
  	if upvoted_by user_id
  		"Upvoted"
  	else
  		"Upvote"
  	end
  end
end
