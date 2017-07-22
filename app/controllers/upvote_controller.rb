class UpvoteController < ApplicationController

	# POST /upvote
	def toggle_upvote
		@answer = Answer.find(params[:ans_id])

		#prevent user from upvoting own answer
		if @answer.my_ans? current_user.id
			return redirect_to '/myAnswers', :flash => { :alert => "Cannot upvote you own answer! :(" }
		end

		upvote = Upvote.where(users: current_user, answer: @answer).first

		if upvote
			upvote.destroy!
			@is_upvoted	= false
		else
			Upvote.create(users_id: current_user.id, answer_id: @answer.id)
			@is_upvoted = true
		end	

		respond_to do |format|
			format.js { }
		end
	end
end
