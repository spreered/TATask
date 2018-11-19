class Admin::UsersController < ApplicationController
  before_action :set_user, only: %i[edit update show destroy start done]
  def index
    @users = User.page(params[:page]).per(20)
  end
  def show
    @q = Task.includes(:user).where(users:{id: @user.id}).ransack(params[:q])
    @tasks = @q.result.page(params[:page]).per(20)
  end
  def new
  end
  def create
  end
  def edit
  end
  def update
  end
  def destroy
  end
  private

  def set_user
    @user = User.find_by(id: params[:id])
    return redirect_to admin_root_path if @user.nil?
  end
end
