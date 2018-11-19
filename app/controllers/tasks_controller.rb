class TasksController < ApplicationController
  before_action :set_task, only: %i[edit update show destroy start done]
  def index
    @q = Task.ransack(params[:q])
    @tasks = params[:q] ? @q.result.includes(:user).where(users: {id: current_user.id}).page(params[:page]).per(20) : 
    Task.includes(:user).where(users: {id: current_user.id}).order(created_at: :desc).page(params[:page]).per(20)
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user = current_user
    # temperary user assign
    if @task.save
      flash[:notice] = t('.notice')
      redirect_to task_path(@task)
    else
      render :new
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