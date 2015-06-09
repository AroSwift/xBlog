Rails.application.routes.draw do
  # bundle exec rake routes

  root 'users#index'

  get     'post'      => 'posts#post'
  post    'post'      => 'posts#create'  
  delete  'post'      => 'posts#destroy'

  patch   'edit_post' => 'posts#update'  
  post    'edit_post' => 'posts#edit_post'
  get     'edit_post' => 'posts#edit_post'

  get     'login'     => 'users#login'
  post    'login'     => 'sessions#create'
  delete  'logout'    => 'sessions#destroy'

  get     'index'     => 'users#signup'
  get     'signup'    => 'users#signup'
  post    'signup'    => 'users#create'
  get     'home'      => 'users#index'

  resources :users
  resources :sessions
  resources :posts
end