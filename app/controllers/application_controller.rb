class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except:[:index]

  require 'stripe'
  Stripe.api_key = 'sk_test_51NZtsnSEyG9G8QDeeoETaR27rX8O9KaFfRGhS6sQzshpoTDR5kxQK51i7EDLySxGtz6t7TxEJFeHpUlOhOpbfexm00Gly8blNP'


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
