class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(id: session_params[:id_or_email].tr("０-９", "0-9")) ||
      User.find_by(email: session_params[:id_or_email].downcase)
    if user&.authenticate(session_params[:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      flash[:success] = 'ログインしました。'
      redirect_to user_path(user.id)
    else
      flash[:danger] = 'id、メールアドレスまたはパスワードが違います。'
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
    params.require(:session).permit(:id_or_email, :password)
  end
end
