class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end
  def show
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      return redirect_to root_path
    end
  end

end
