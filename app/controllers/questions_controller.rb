class QuestionsController < ApplicationController

  def index
    @questions = Question.all
    if params[:order] == "votes"
      render_page
      @questions = Question.all.sort_by {|q| q.votes.count }.reverse
    elsif params[:order] == "trending"
      render_page
      @questions = Question.all.sort_by {|q| [q.elapsed, -1 * q.votes.count] }
    else
      render_page
      @questions = Question.order(created_at: :desc)
    end
  end

  def show
    render_page
    @question = Question.find(params[:id])
    @comment = Comment.new
    @answer = Answer.new
  end

  def new
    if is_authenticated?
      flash[:notice] = ""
      render_page
      @question = Question.new
      render :new, layout: false
    end
  end

  def create
    @question = current_user.questions.build(question_params)
    if @question.save
      redirect_to '/questions'
    else
      flash[:notice] = "Invalid url/title"
      render :action => :new
    end
  end

  private
    def question_params
      params.require(:question).permit(:url, :title)
    end

    def render_page
      STATSD.increment('web.page_views', :tags => ['support', 'page:questions'])
    end

end