Rails.application.routes.draw do
  root 'users#index'

  get     'post'    => 'posts#post'
  post    'post'    => 'posts#create'  
  delete  'post'   => 'posts#destroy'

  get     'login'   => 'users#login'
  post    'login'   => 'sessions#create'
  delete  'logout'  => 'sessions#destroy'

  get     'index'   => 'users#signup'
  get     'signup'  => 'users#signup'
  post    'signup'  => 'users#create'
  get     'home'    => 'users#index'

  resources :users
  resources :sessions
end