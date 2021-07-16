Rails.application.routes.draw do
  root "sessions#home"

  #signup route
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  
  resources :categories
  resources :comments
  resources :recipes
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
