class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_login, except: [:new, :create]

  def new
    @user = User.new
    render :new, layout: false
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        set_session
        format.html { redirect_to @user, notice: 'User Created' }
        format.json { render :user, status: :created, location: @user }
      else
        format.html { redirect_to :new_user }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User Updated' }
        format.json { render :show, status: :updated, location: @user }
      else
        format.html { redirect to :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    session.clear if @user == current_user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to login }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end


end