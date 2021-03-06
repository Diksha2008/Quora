class HomeController < SetLayoutController
	before_action :authenticate_user!
  def index
  	@questions = Question.all
  end

  #GET /profile
  def profile
  end

  #GET /myAnswers
  def my_answers
    @answers = current_user.answers
  end

  #GET /myQuestions
  def my_questions
    @questions = current_user.questions
    @answer = Answer.new
  end

  #POST /home/upload_image
  def upload_image
  	uploaded_file = params[:image]
  	filename = SecureRandom.hex + "." + uploaded_file.original_filename.split('.')[1]
  	filepath = Dir.pwd + "/public/uploads/" + filename
  	File.open(filepath, "wb") do |file|
  		file.write(uploaded_file.read())
  	end
  	current_user.profile_picture = filename
  	current_user.save!
  	return redirect_to '/profile'
  end
end
