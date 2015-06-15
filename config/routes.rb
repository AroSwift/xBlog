Rails.application.routes.draw do
  # bundle exec rake routes

  root 'users#index'

  get     'signup'              => 'users#signup'
  post    'signup'              => 'users#create'
  get     'home'                => 'users#index'

  get     'login'               => 'users#login'
  post    'login'               => 'users#show'
  delete  'logout'              => 'users#logout'

  get     'post'                => 'posts#post'
  post    'post'                => 'posts#create'  
  delete  'post'                => 'posts#destroy'

  put     'edit_post'           => 'posts#update'
  get     'edit_post'           => 'posts#edit_post'

  get     'admin_home'          => 'admin#index'
  get     'admin_users'         => 'admin#users'
  put     'admin_edit_users'    => 'admin#update'
  delete  'admin_logout'        => 'admin#logout'

  resources :users
  resources :posts
  resources :admin
end