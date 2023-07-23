Rails.application.routes.draw do
  # get 'quizzes/index'
  # get 'quizzes/new'
  # get 'quizzes/show'
  # get 'quizzes/edit'
  # get 'quizzes/destroy'
  # # get 'lectures/index'
  # get 'lectures/new'
  # get 'lectures/create'
  # get 'lectures/edit'
  # get 'lectures/update'
  # get 'lectures/show'
  # get 'lectures/destroy'
  # get 'enrollments/index'
  # get 'enrollments/new'
  # get 'enrollments/create'
  # get 'enrollments/edit'
  # get 'enrollments/update'
  # get 'enrollments/show'
  # get 'enrollments/destroy'
  # get 'homes/index'
  # get 'courses/index'
  # get 'courses/new'
  # get 'courses/edit'
  # get 'courses/destroy'
  # get 'courses/show'
   get 'courses/mycourse'
get 'lectures/mylecture'


  root "homes#index"
  resources :instructors  
  resources :enrollments, only: [:index]

  resources :courses do
    # post 'enroll', to: 'enrollments#create', on: :member      
    get 'enroll', to: 'enrollments#create'
    get 'mylecture', to: 'lectures#mylecture'
    resources :lectures do
      resources :quizzes, only: [:new,:create,:show]
    end

  end
  resources :students
   resources :homes 
  #     get 'show', on: :member, constraints: lambda { |req| !req.session[:user_id].present? }
  # end


  devise_for :users, :controllers => {registrations: 'registrations'}
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
   

end
