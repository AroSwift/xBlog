Rails.application.routes.draw do
  # bundle exec rake routes

  root 'users#index'

  get     'post'      => 'posts#post'
  post    'post'      => 'posts#create'  
  delete  'post'      => 'posts#destroy'

  put     'edit_post' => 'posts#update'
  get     'edit_post' => 'posts#edit_post'

  get     'login'     => 'users#login'
  post    'login'     => 'users#show'
  delete  'logout'    => 'users#destroy'

  get     'index'     => 'users#signup'
  get     'signup'    => 'users#signup'
  post    'signup'    => 'users#c reate'
  get     'home'      => 'users#index'

  resources :users
  resources :sessions
  resources :posts
end