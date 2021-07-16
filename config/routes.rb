Rails.application.routes.draw do
  root "sessions#home"

  #signup route
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'

  #login route
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'

   #logout route
   delete '/logout' => 'sessions#destroy'# Important that its delete so that the user cant view it in the url bar 
  
  resources :recipes do
    resources :comments
  end

  resources :comments
  
  resources :users do
    resources :recipes, only: [:new, :create, :index]
  end

  resources :categories, only: [:index, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
