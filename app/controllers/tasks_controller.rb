class TasksController < ApplicationController
  before_action :authenticate_user
  before_action :set_task, only: %i[edit update show destroy start done]
  before_action :current_user_post?, only: %i[edit update show destroy start done]
  def index
    @q = Task.ransack(params[:q])
    @tasks = params[:q] ? @q.result.includes(:user,:tags).where(users: {id: current_user.id}).page(params[:page]).per(20) : 
    Task.includes(:user,:tags).where(users: {id: current_user.id}).order(created_at: :desc).page(params[:page]).per(20)
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
    params.require(:task).permit(:title, :content, :deadline, :priority,
    {tag_items:[]})
  end

  def set_task
    @task = Task.find_by(id: params[:id])
    return not_found if @task.nil?
  end

  def current_user_post?
    return not_found if @task.user != current_user
  end
end