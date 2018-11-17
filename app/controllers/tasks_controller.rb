class TasksController < ApplicationController
  before_action :set_task, only: %i[edit update show destroy start done]
  def index
    # @tasks = Task.all.order(created_at: :desc)
    sort_params = { "created_asc" => "created_at ASC",
     "created_desc" => "created_at DESC", 
     "deadline_desc" => "deadline DESC",
      "deadline_asc" => "deadline ASC",
    "priority_asc" => "priority ASC",
    "priority_desc" => "priority DESC" }
    @q = Task.ransack(params[:q])
    puts "q is #{@q.result}"
    @tasks = @q.result.ordered(sort_params[params[:sort]])
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:notice] = t('.notice')
      redirect_to task_path(@task)
    else
      render new_task_path
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:notice] = t('.notice')
      redirect_to task_path(@task)
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    flash[:alert] = t('.notice')
    redirect_to root_path
  end

  def start
    if @task.todo?
      @task.start!
    end
    redirect_back(fallback_location: root_path)
  end

  def done
    if !@task.completed?
      @task.done!
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def task_params
    params.require(:task).permit(:title, :content, :deadline, :priority)
  end

  def set_task
    @task = Task.find_by(id: params[:id])
    return redirect_to root_path if @task.nil?
  end
end