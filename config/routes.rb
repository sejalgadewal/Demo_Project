Rails.application.routes.draw do
  root "courses#index" 
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
  
  resources :rooms do
      resources :messages
  end

  get 'courses/mycourse'
  resources :enrollments, only: [:index]
  get 'enrollments/showquiz/:lecture_id', to: 'enrollments#showquiz', as: :showquiz

  resources :courses do
      get 'enroll', to: 'enrollments#create'
      get 'mylecture', to: 'lectures#mylecture'
      resources :lectures do
          get 'myquiz', to: 'quizzes#myquiz'
          resources :quizzes, only: [:new,:create,:show,:edit,:update,:destroy]
      end
  end
  
  resources :quizzes, only: [:new,:create,:show,:edit,:update,:destroy] do
      resources :questions, only: [:new, :index, :create,:show,:edit,:update,:destroy]
  end

  devise_for :users, :controllers => {registrations: 'registrations'}

  namespace :api do
    namespace :v1 do
      resources :courses do
        get 'enroll', to: 'enrollments#create'
        get 'mylecture', to: 'lectures#mylecture'
        resources :lectures do
          get 'myquiz', to: 'quizzes#myquiz'
          resources :quizzes, only: [:new,:create,:show,:edit,:update,:destroy]
        end
      end
    end
  end
  
end
