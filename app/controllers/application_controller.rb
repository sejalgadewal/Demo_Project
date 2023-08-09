class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session
  before_action :configure_permitted_parameters, if: :devise_controller?
  
   #before_action :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to courses_path, alert: 'Access denied.'
  end

  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
    	if resource.role == 'Instructor'
         courses_path
        #api_v1_courses_path
      else
        #api_v1_courses_path
         courses_path
      end
    end
  end
 
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name avatar])
  end
end
