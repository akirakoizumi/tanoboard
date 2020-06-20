class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: session_params[:email].downcase)
    if user&.authenticate(session_params[:password])
      log_in user
      redirect_to user_path(user.id), notice: 'ログインしました。'
    else
      render :new
    end
  end

  def destroy
    log_out
    @current_user = nil
    redirect_to root_url, notice: 'ログアウトしました。'
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
