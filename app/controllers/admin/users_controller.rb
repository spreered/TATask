class Admin::UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).per(20)
  end
  def show
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
  
end
