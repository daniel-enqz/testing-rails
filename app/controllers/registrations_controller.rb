class RegistrationsController < Devise::RegistrationsController
  private

  def sign_up_params
    params.require(:author).permit(
      :email, :password, :password_confirmation,
      :name, :last_name
    )
  end

  def account_update_params
    params.require(:author).permit(
      :email, :password, :password_confirmation,
      :name, :last_name
    )
  end

  def after_inactive_sign_up_path_for(_resource)
    new_profile_path
  end
end
