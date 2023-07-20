class ApplicationController < ActionController::Base
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
