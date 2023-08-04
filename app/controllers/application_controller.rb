class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!, except:[:index]

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to courses_path, alert: 'Access denied.'
  end

  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
    	if resource.role == 'Instructor'
        courses_path
      else
        courses_path
      end
    end
  end
end
