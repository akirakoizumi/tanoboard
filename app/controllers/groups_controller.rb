class GroupsController < ApplicationController
  before_action :logged_in_user
  before_action :require_admin, only: %i(new create update edit update)

  PER = 12

  def show
    @group = Group.find(params[:id])
    @tasks = Task.where(group_id: params[:id]).includes(:user).recent.page(params[:page]).per(PER)
    @task = Task.new
    group_in(@group)
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      @group.users << current_user
      group_in(current_user)
      flash[:success] = 'グループを作成しました'
      redirect_back_or group_path(@group)
    else
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      flash[:success] = 'グループ情報を編集しました。'
      redirect_to @group
    else
      render 'edit'
    end
  end

  # デフォルトグループをセット
  def set_defaultuser
    if admin?
      @group = Group.find(params[:id])
      if @group.present?
        current_user.default_group_id = @group.id
        current_user.save!
        flash[:success] = "#{@group.name} をデフォルトグループに設定しました"
        flash.discard
      end
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    flash[:success] = "グループ「#{@group.name}」を削除しました"
    redirect_to root_url
  end

  private

  def group_params
    params.require(:group).permit(:name, :description, { user_ids: [] })
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :default_group_id)
  end
end
