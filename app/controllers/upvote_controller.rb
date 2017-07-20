class UpvoteController < ApplicationController

	# POST /upvote
	def newUpvote
		answer = Answer.find(params[:ans_id])
		upvote = Upvote.where(users: current_user, answer: answer).first
		if upvote
			upvote.destroy!
		else
			Upvote.create(users_id: current_user.id, answer_id: answer.id)
		end	
		return redirect_to '/'
	end
end
