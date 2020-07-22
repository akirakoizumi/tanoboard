module TasksHelper
  def collect_user?(task)
    task.user == current_user
  end
end
