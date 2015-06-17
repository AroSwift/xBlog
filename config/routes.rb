Rails.application.routes.draw do
  # bundle exec rake routes

  root 'users#index'

  get     'home'                => 'users#index'
  get     'signup'              => 'users#signup'
  post    'signup'              => 'users#create'

  get     'login'               => 'users#login'
  post    'login'               => 'users#show'
  delete  'logout'              => 'users#logout'

  get     'post'                => 'posts#post'
  post    'post'                => 'posts#create'  
  delete  'post'                => 'posts#destroy'

  put     'edit_post'           => 'posts#update'
  get     'edit_post'           => 'posts#edit_post'

  get     'account'             => 'users#account'
  put     'account'             => 'users#request_admin'

  get     'admin_home'          => 'admin#index'
  get     'admin_users'         => 'admin#users'
  get     'admin_edit_users'    => 'admin#edit_users'
  put     'admin_edit_users'    => 'admin#update'
  delete  'admin_logout'        => 'admin#logout'
  delete  'admin_users'         => 'admin#destroy'

  # If no page exists, redirect to home
  get '*a' => redirect("/")


  resources :users
  resources :posts
  resources :admin
  
end