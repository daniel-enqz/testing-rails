Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root 'books#index'
  devise_for :authors, controllers: { registrations: 'registrations' }
  resources :books
end
