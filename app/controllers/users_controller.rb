class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      redirect_to user_url(@user), notice: "ユーザー「#{@user.name}」を登録しました"
      # flash[:success] = 'ユーザー登録が完了しました。'
      # log_in(@user)
      # redirect_to @user
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def edit_password
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'アカウント情報を編集しました。'
      redirect_to @user
    else
      render edit_user_path @user
    end
  end

  def update_password
    @user = User.find(params[:id])
    if @user.update_attributes(user_params_password_only)
      flash[:success] = 'パスワードを変更しました。'
      redirect_to @user
    else
      render edit_password_user_path
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to user_url, notice: "ユーザー「#{@user.name}」を削除しました"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # 正しいユーザーかどうか確認
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
