class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: session_params[:email].downcase)
    if user&.authenticate(session_params[:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      flash[:success] = 'ログインしました。'
      redirect_to user_path(user.id)
    else
      render :new
    end
  end

  def destroy
    log_out
    @current_user = nil
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
