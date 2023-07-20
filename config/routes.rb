Rails.application.routes.draw do
  get 'enrollments/index'
  get 'enrollments/new'
  get 'enrollments/create'
  get 'enrollments/edit'
  get 'enrollments/update'
  get 'enrollments/show'
  get 'enrollments/destroy'
  get 'homes/index'
  get 'courses/index'
  get 'courses/new'
  get 'courses/edit'
  get 'courses/destroy'
  get 'courses/show'
  get 'courses/mycourse'
  root "homes#index"
  resources :instructors  
    resources :courses 
  
  resources :students
   resources :homes 
  #     get 'show', on: :member, constraints: lambda { |req| !req.session[:user_id].present? }
  # end


  devise_for :users, :controllers => {registrations: 'registrations'}
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
   

end
