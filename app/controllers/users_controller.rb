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

  def new_sub
    @user = User.new
    @group = Group.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    @user.admin = true
    if @user.save!
      log_in(@user)
      flash[:success] = "ユーザー「#{@user.name}」を登録しました"
      redirect_to user_url(@user)
    else
      render :new
    end
  end

  def create_sub
    @user = User.new(user_params)
    @user.admin = false
    if @user.save
      group = Group.find(params[:user][:group_id])
      group.users << @user
      flash[:success] = "サブユーザー「#{@user.name}」を登録しました"
      redirect_to group
    else
      flash[:danger] = '入力内容に誤りがあります。'
      redirect_to new_sub_user_path
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
      flash[:success] = 'パスワードを変更しました。'
      redirect_to @user
    else
      render 'edit_password'
    end
  end

  def destroy
    @user = User.find(params[:id])
    log_out
    @current_user = nil
    @user.destroy
    flash[:success] = "ユーザー「#{@user.name}」を削除しました"
    redirect_to root_url
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def sub_user_params
    params.permit(:name, :password, :password_confirmation, :group_id)
  end
end
