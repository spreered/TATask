class SessionsController < ApplicationController
  def new
    if current_user
      redirect_to root_path
    end
  end
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      flash[:notice] = t('.notice')
      login user
      redirect_to root_path
    else
      flash[:alert] = t('.alert')
      render :new
    end
  end
  def destroy
    logout
    flash[:notice] = t('.notice')
    redirect_to login_path
  end
  
end
