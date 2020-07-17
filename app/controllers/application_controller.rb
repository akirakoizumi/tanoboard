class ApplicationController < ActionController::Base
  include SessionsHelper
  helper_method :current_user
  helper_method :current_group

  private

  # ログイン済みユーザーかどうか確認
  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = 'ログインしてください'
    redirect_to login_url
  end

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
    elsif current_user.default_group_id
      @current_group ||= Group.find_by(id: current_user.default_group_id)
      session[:group_id] = current_user.default_group_id
    end
  end
end
