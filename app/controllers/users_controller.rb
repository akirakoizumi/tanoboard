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
      flash[:success] = "ユーザー「#{@user.name}」を登録しました"
      redirect_to user_url(@user)
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
    if @user.update_attributes(user_params)
      flash[:success] = 'アカウント情報を編集しました。'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def update_password
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # if @user.valid?(:registration)
      # @user.update(user_params)
      flash[:success] = 'パスワードを変更しました。'
      redirect_to @user
    else
      render 'edit_password'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "ユーザー「#{@user.name}」を削除しました"
    redirect_to user_url
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def user_params2
    params.require(:user).permit(:name, :email)
  end
end
