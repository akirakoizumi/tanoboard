class UsersController < ApplicationController
  # ログインしているユーザーか確認
  before_action :logged_in_user, only: %i(
    show edit name_edit edit_password upload
    update_name update_password destroy
  )
  before_action :correct_user, only: %i(
    new_sub create create_sub edit name_edit edit_password
    update update_name update_password destroy
  )
  before_action :correct_group, only: %i(
    show
  )
  before_action :require_admin, only: %i(new_sub create_sub edit update)

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
      redirect_back_or user_url(@user)
    else
      render :new
    end
  end

  def create_sub
    @user = User.new(user_params)
    @group = Group.find(params[:id])
    @user.admin = false
    @user.default_group_id = @group.id
    if @user.save
      @group = Group.find(params[:id])
      @group.users << @user
      flash[:success] = "サブユーザー「#{@user.name}」を登録しました"
      redirect_to group_path
    else
      flash[:danger] = '入力内容に誤りがあります。'
      redirect_to new_sub_user_path
    end
  end

  def edit
    @user = User.find(params[:id])
    redirect_to name_edit_user_path unless @user.admin?
  end

  def name_edit
    @user = User.find(params[:id])
    redirect_to edit_user_path if @user.admin?
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

  def update_name
    @user = User.find(params[:id])
    if @user.update_attribute(:name, params[:user][:name])
      flash[:success] = '名前を変更しました。'
      redirect_to @user
    else
      render 'name_edit'
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
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :default_group_id)
  end

  def sub_user_params
    params.permit(:name, :password, :password_confirmation, :group_id, :default_group_id)
  end

  # 同じグループのユーザーか確認
  def correct_group
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user.groups.include?(current_group)
  end

  # 正しいユーザーかどうか確認
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
