class Question < ActiveRecord::Base
  validates :content, presence: true
  belongs_to :user
  has_many :answers
  has_many :QuestionFollowMappings

  cattr_accessor :current_user

  def has_answer?
  	return answers.where.not(:user_id => current_user.id).count > 0
  end

  def random_ans user_id
  	return answers.where.not(user_id: user_id).order("RANDOM()").first
  end

  def is_followed user_id
    return QuestionFollowMapping.where(question_id: id, user_id: user_id).length > 0
  end

  def is_followed_string user_id
    if is_followed user_id
      return "Unfollow"
    else
      return "Follow"
    end
  end
end
