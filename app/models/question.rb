class Question < ActiveRecord::Base
  validates :content, presence: true
  belongs_to :user
  has_many :answers

  cattr_accessor :current_user

  def has_answer?
  	return answers.where.not(:user_id => current_user.id).count > 0
  end

  def random_ans
  	answers.order("RANDOM()").first;
  end
end
