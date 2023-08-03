Rails.application.routes.draw do
    get 'messages/new'
    get 'rooms/index'  
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
    
    #post '/checkouts/create', to: 'checkouts#create'
    resources :rooms do
        resources :messages
    end

    get 'courses/mycourse'
    get 'lectures/mylecture'
    get 'quizzes/myquiz'

    root "courses#index"
    resources :enrollments, only: [:index]
    resources :courses do
        get 'enroll', to: 'enrollments#create'

        #post '/payments/enroll_in_course', to: 'payments#enroll_in_course'
        #post '/checkouts/create', to: 'checkouts#create'
    
        #resources :payments, only: [:new, :create]
        get 'mylecture', to: 'lectures#mylecture'
        resources :lectures do
            get 'myquiz', to: 'quizzes#myquiz'
            resources :quizzes, only: [:new,:create,:show,:edit,:update,:destroy]
        end
    end
    
    get 'payments/:course_id', to: 'payments#payment_page', as: :payment_page
    post 'payments/:course_id', to: 'payments#payment_process', as: :payment_process
    post 'payments/confirm_payment', to: 'payments#confirm_payment', as: :confirm_payment

    #post 'payment', to: 'payment#enroll_in_course'

    resources :quizzes, only: [:new,:create,:show,:edit,:update,:destroy] do
        resources :questions, only: [:new, :index, :create,:show,:edit,:update,:destroy]
    end
    devise_for :users, :controllers => {registrations: 'registrations'}
 
end
