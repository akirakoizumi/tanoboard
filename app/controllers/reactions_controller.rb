class ReactionsController < ApplicationController
  def create
    reactions = current_user.reactions.build(task_id: params[:task_id])
    reactions.save
    redirect_to group_path(current_group)
  end

  def destroy
    reactions = Reaction.find_by(task_id: params[:task_id], user_id: current_user.id)
    reactions.destroy
    redirect_to group_path(current_group)
  end
end
