class SessionsController < ApplicationController

  def new
    @user = User.new
    render :new, layout: false
  end

  def create
    @user = User.find_by(username: params[:user][:username]).try(:authenticate, params[:user][:password])
    respond_to do |format|
      if @user
        set_session
        format.html { redirect_to @user }
        format.json { render json: :user, status: :logged, location: @user }
      else
        format.html { redirect_to '/' }
        format.json { render json: @user.errors }
      end
    end
  end

  def destroy
    session.clear
    redirect_to '/'
  end
end