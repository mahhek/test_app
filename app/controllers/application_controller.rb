class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    if current_user.role == "admin"
      "/admin/dashboard"
    elsif current_user.role == "client"
      "/dashboard"
    end
  end

  def after_update_path_for(resource)
    user_path(resource)
  end

  def authentication_for_admin
    if current_user && current_user.role != "admin"
      flash[:notice] = "Not authenticated!"
      redirect_to "/"
    end
  end
end
