Rails.application.routes.draw do
  get 'students/show'
  get 'messages/new'
  get 'rooms/index'
 

  # devise_scope :users do
  #    get 'users/:id', to: 'registrations#show', as: 'user'
  # end
 # get 'users/:id', to: 'users#show', as: 'user'
  
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
  resources :rooms do
    resources :messages
  end

   get 'courses/mycourse'
get 'lectures/mylecture'
get 'quizzes/myquiz'

  root "homes#index"

  resources :instructors  
  resources :enrollments, only: [:index]

  resources :courses do
    # post 'enroll', to: 'enrollments#create', on: :member      
    get 'enroll', to: 'enrollments#create'
    get 'mylecture', to: 'lectures#mylecture'
    resources :lectures do
      get 'myquiz', to: 'quizzes#myquiz'
      resources :quizzes, only: [:new,:create,:show,:edit,:update,:destroy] do
     #   resources :questions, only: [:new,:create,:show,:edit,:update,:destroy]
      
      end
    end
  end

  resources :quizzes, only: [:new,:create,:show,:edit,:update,:destroy] do
    resources :questions, only: [:new, :index, :create,:show,:edit,:update,:destroy] do
      post 'submit_answer', on: :member
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
