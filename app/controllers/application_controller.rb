class ApplicationController < ActionController::Base
  include SessionsHelper
  helper_method :current_user

  private

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    elsif cookies.signed[:user_id]
      user = User.find_by(id: cookies.signed[:user_id])
      if user && user.authenticated?(cookies[:remember_token])
        @current_user = user
      end
    end
  end

  def current_group
    if session[:group_id]
      @current_group ||= Group.find_by(id: session[:group_id])
    end
  end
end
