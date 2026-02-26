class ApplicationController < ActionController::Base

  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  private

  def set_locale
    # Pobiera parametr ?locale=en, jeśli go brak - używa domyślnego
    I18n.locale = params[:locale] || I18n.default_locale
  end

  # Opcjonalnie: sprawia, że linki (np. post_path) automatycznie 
  # dodają aktualny parametr locale do URL
  def default_url_options
    { locale: I18n.locale }
  end

  def configure_permitted_parameters
    # Dla rejestracji (sign_up)
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :surname])
    
    # Dla edycji profilu (account_update)
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :surname])
  end
end
