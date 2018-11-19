class ApplicationController < ActionController::Base
  include SessionsHelper
  
  def authenticate_user
    unless current_user
      flash[:alert] = t('users.must_login')
      return redirect_to login_path
    end
  end
end
