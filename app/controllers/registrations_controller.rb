class RegistrationsController < Devise::RegistrationsController
  protected

  def after_update_path_for(resource)
    if current_user.role == "admin"
      "/admin/dashboard"
    elsif current_user.role == "client"
      "/dashboard"
    end
  end
end