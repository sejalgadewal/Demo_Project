Rails.application.routes.draw do
  get 'courses/index'
  get 'courses/new'
  get 'courses/edit'
  get 'courses/destroy'
  resources :courses
  devise_for :users, :controllers => {registrations: 'registrations'}
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
   root "courses#index"

end
