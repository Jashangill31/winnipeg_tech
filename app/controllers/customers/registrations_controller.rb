class Customers::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  def new
    Rails.logger.info "💥 CUSTOM REGISTRATION CONTROLLER LOADED 💥"
    @provinces = Province.all
    super
  end

  def edit
    @provinces = Province.all
    super
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:province_id])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:province_id])
  end
end
