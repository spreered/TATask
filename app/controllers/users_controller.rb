class UsersController < ApplicationController
  before_action :authenticate_user, only: %i[show edit update]
  def show
    @user = User.find_by(id: params[:id])
    unless @user
      flash[:alert] = t('.alert')
      return redirect_to root_path
    end
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = t('.notice')
      login @user
      redirect_to root_path
    else
      render :new
    end
  end
  def edit
    @user = User.find_by(id: params[:id])
    unless @user
      return redirect_to root_path
    end
  end
  def update
    @user = User.find_by(id: params[:id])
    
    unless @user
      return redirect_to root_path
    end
    update_params = {}
    user_params.each do |key, value|
      update_params[key] = value unless value.blank?
    end

    if @user.update(update_params)
      flash[:notice] = t('.notice')
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private 
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
