class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up do |user_params|
      user_params.permit :name, :phone, :address,
       :email, :password, :password_confirmation, :role
    end
    devise_parameter_sanitizer.permit :account_update do |user_params|
      user_params.permit :name, :phone, :address,
       :email, :password, :password_confirmation, :role
    end
  end
end
