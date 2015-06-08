Rails.application.routes.draw do
  # bundle exec rake routes

  root 'users#index'

  get     'post'    => 'posts#show'
  post    'post'    => 'posts#create'  
  delete  'post'   => 'posts#destroy'

  get     'login'   => 'users#login'
  post    'login'   => 'sessions#create'
  delete  'logout'  => 'sessions#destroy'

  get     'signup'  => 'users#signup'
  post    'signup'  => 'users#create'
  get     'home'    => 'users#index'

  resources :users
  resources :sessions
  resources :posts
end