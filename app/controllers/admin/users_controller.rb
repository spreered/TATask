class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: %i[edit update show destroy start done]
  def index
    @users = User.page(params[:page]).per(20)
  end
  def show
    @q = Task.includes(:user).where(users:{id: @user.id}).ransack(params[:q])
    @tasks = @q.result.page(params[:page]).per(20)
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = t('.notice')
      redirect_to admin_root_path
    else
      render :new
    end
  end
  def edit
    @user = User.find_by(id: params[:id])
    unless @user
      return redirect_to admin_root_path
    end
  end
  def update
    @user = User.find_by(id: params[:id])
    
    unless @user
      return redirect_to admin_root_path
    end
    update_params = {}
    user_params.each do |key, value|
      update_params[key] = value unless value.blank?
    end

    if @user.update(update_params)
      flash[:notice] = t('.notice')
      redirect_to admin_root_path
    else
      render :edit
    end
  end
  def destroy
    @user.destroy
    flash[:alert] = t('.notice')
    redirect_to admin_root_path
  end
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
  end

  def set_user
    @user = User.find_by(id: params[:id])
    return redirect_to admin_root_path if @user.nil?
  end
end
