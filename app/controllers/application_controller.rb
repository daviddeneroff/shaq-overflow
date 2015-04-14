class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  #USER AUTH

  def current_user
     User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def is_authenticated?
    !!session[:user_id]
  end

  def require_login
    redirect_to root_url unless is_authenticated?
  end

  def set_session
    if @user
      session[:user_id] = @user.id
      require_login
    end
  end

  #ERROR HANDLING (see https://github.com/zencephalon/moosetalk/blob/master/app/helpers/error.rb)

  def add_error!(error_msg)
    if session[:errors]
      session[:errors] << error_msg
    else
      session[:errors] = [error_msg]
    end
  end

  def display_errors!
    errors = session[:errors]
    session[:errors] = nil
    errors.join(", ") if errors
  end

  def parse_ar_errors_for_display!(messages)
    messages.each do |key, arr|
      arr.each do |err|
        add_error!("#{key}: #{err}")
      end
    end
  end

end
