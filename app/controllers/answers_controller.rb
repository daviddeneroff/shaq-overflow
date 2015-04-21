class AnswersController < ApplicationController

  def index
    @answers = Answer.all
  end

  def show
    @answer = Answer.find(params[:id])
  end

  def new
    @answer = Answer.new
    @question = Question.find(params[:question_id])
    render :new, layout: false
  end

  def create
    start_time = Time.now
    @answer = Answer.new(answer_params)
    @answer.user = User.find(current_user.id)
    @answer.question = Question.find(params[:question_id])
    if @answer.save
      duration = Time.now - start_time
      STATSD.histogram('database.query.time', duration, :tags => ['support'])
      redirect_to question_path(@answer.question)
    else
      render :new
    end
  end

  def edit
    @answer = Answer.find params[:id]
    @question = Question.find(params[:question_id])
  end

  def update
    @answer = Answer.find params[:answer][:answer_id]
    @answer.update_attributes(accepted: true)
    redirect_to "/questions/#{@answer.question_id}"
  end

  def destroy
    article = Article.find params[:id]
    article.destroy
    redirect_to root_path
  end

private
  def answer_params
    params.require(:answer).permit(:content, :accepted)
  end
end