class ApplicationController < ActionController::Base
  include SessionsHelper
  
  def authenticate_user
    unless current_user
      flash[:alert] = t('users.must_login')
      return redirect_to login_path
    end
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  rescue
    render_404
  end

  def render_404
    render file: "#{Rails.root}/public/404", status: :not_found, layout: false
  end
  
end
