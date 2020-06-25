class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @users = @group.users.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      @group.users << current_user
      log_in(current_user)
      flash[:success] = 'グループを作成しました'
      redirect_to group_path(@group)
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

  private

  def group_params
    params.require(:group).permit(:name, :description, { user_ids: [] })
  end
end
