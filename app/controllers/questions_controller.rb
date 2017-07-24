class QuestionsController < SetLayoutController
  before_action :set_question, only: [:show, :edit, :update, :destroy, :follow_question]
  before_action :authenticate_user!
  # def index
  #   @questions = Question.all
  # end

  # GET /questions/1/edit
  def edit
  end

  # GET /questions/1
  # GET /answers/1.json
  def show
    @answer = @question.answers.where(user: current_user).first
  end
  

  # POST /questions
  # POST /questions.json
  def create
    @answer = Answer.new # for form in /answers(js request)
    @question = Question.new(question_params)
    @question.user = current_user

    respond_to do |format|
      if @question.save
        format.html { redirect_to '/answers', notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
        format.js { }
      else
        format.html { redirect_to '/answers', alert: 'Question cannot be blank! :(' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  #POST /followQuestion/:id
  def follow_question
    follow_mapping = QuestionFollowMapping.where(question: @question, user: current_user).first
    
    if follow_mapping
      follow_mapping.destroy!
      @is_followed = false
    else
      QuestionFollowMapping.create(user: current_user, question: @question)
      @is_followed = true
    end
    respond_to do |format|
      format.js { }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:content, :user_id)
    end
end
