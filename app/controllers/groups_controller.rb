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
      redirect_to group_path(@group), notice: 'グループを作成しました'
    else
      render :new
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :description, { user_ids: [] })
  end
end
