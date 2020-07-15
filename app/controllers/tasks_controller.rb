class TasksController < ApplicationController
  def index
  end

  def show
    @task = Task.find(params[:id])
    @users = @task.all_reaction_user
  end

  def create
    @task = current_user.tasks.new(task_params)
    if @task.save
      flash[:success] = 'タスクを登録しました。'
      redirect_to group_path(session[:group_id])
    else
      flash[:danger] = '登録に失敗しました。'
      redirect_to group_path(session[:group_id])
    end
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy!
    flash[:success] = 'タスクを削除しました。'
    redirect_to group_path(session[:group_id])
  end

  private

  def task_params
    params.require(:task).permit(:content, :user_id, :group_id)
  end
end
