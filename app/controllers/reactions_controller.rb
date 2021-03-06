class ReactionsController < ApplicationController
  def create
    @task = Task.find(params[:task_id])
    reactions = current_user.reactions.build(task_id: params[:task_id])
    reactions.save
    @users = @task.all_reaction_user
  end

  def destroy
    @task = Task.find(params[:task_id])
    reactions = Reaction.find_by(task_id: params[:task_id], user_id: current_user.id)
    reactions.destroy
    @users = @task.all_reaction_user
  end
end
