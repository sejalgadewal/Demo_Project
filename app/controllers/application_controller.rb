class ApplicationController < ActionController::Base
    #  before_action :authenticate_instructor!,only: [:new, :create] 
  before_action :authenticate_user!, except:[:index]

  # def authenticate_instructor!
  #   unless current_user.instructor?
  #       redirect_to root_path, 
  #   end
  # end

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
