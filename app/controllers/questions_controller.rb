class QuestionsController < ApplicationController
  def index
    @quiz= Quiz.find(params[:quiz_id])
    @questions = @quiz.questions
    @lecture=@quiz.lecture
    @course=@lecture.course
  end
  def show
  end

  def submit_answer
    selected_answer_id = params[:selected_answer]
    @question_id = Question.find(params[:id])
    @correct_answer=@question_id.correct

    # question_id = params[:question_id]
    # correct_answer = Answer.find(question_id).correct
    
  #  redirect_to course_lecture_quiz_path(params[:course_id], params[:lecture_id], params[:quiz_id]), notice: 'Answer submitted successfully!'
    redirect_to quiz_questions_path(params[:quiz_id]), notice: 'Answer submitted successfully!'
  
  end




  def destroy
    @quiz= Quiz.find(params[:quiz_id])
    @question=@quiz.questions.find(params[:id])
    @question.destroy
    redirect_to quiz_questions_path(@quiz), notice: "Question was successfully Destroyed."
  end

 

  def new
   @quiz= Quiz.find(params[:quiz_id])
   @question=@quiz.questions.new
   @lecture=@quiz.lecture
   @course=@lecture.course
   
  end

  def create
    @quiz= Quiz.find(params[:quiz_id])
    @question=@quiz.questions.create(question_params)

    if @question.save
      redirect_to quiz_questions_path(@quiz), notice: 'Question Successfully created'
    else
      render :new
    end

  end

  def edit
   @quiz= Quiz.find(params[:quiz_id])
   @question=@quiz.questions.find(params[:id])
   @lecture=@quiz.lecture
   @course=@lecture.course
   
  end

  def update
    @quiz= Quiz.find(params[:quiz_id])
   @question=@quiz.questions.find(params[:id])
   
    if @question.update(question_params)
      redirect_to quiz_questions_path(@quiz), notice: "Question was successfully updated."
    else
      render :edit, status: :unprocessable_entity 
    end
  end

  private

  def question_params
    params.require(:question).permit(:quiz_id, :content, :answer1, :answer2, :answer3, :answer4, :correct )
  end
end
