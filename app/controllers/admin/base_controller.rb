class Admin::BaseController < ApplicationController
  before_action :authenticate_admin
  #確認是admin才可以進後台
  layout "admin"
  private 
    def authenticate_admin
      unless current_user.admin?
        # layout "application"
        # error page here
        return not_found
      end
    end
end
