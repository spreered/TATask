class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find_by(id: params[:id])
    return redirect_to root_path if @task.nil?
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to task_path(@task)
    else
      render new_task_path
    end
  end

  private

  def task_params
    params.require(:task).permit(:title, :content)
  end
end