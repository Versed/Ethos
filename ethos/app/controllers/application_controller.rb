class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :first_name, :last_name, :username) }
  end

  def render_permission_error
    render file: 'public/500.html', status: :error, layout: false
  end

  def render_404
    render file: 'public/404.html', status: :not_found
  end
end
