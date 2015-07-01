Rails.application.routes.draw do
  # rake routes

  root 'users#index'

  # Regular functions
  get     'login'                 => 'users#login'
  post    'login_user'            => 'users#login_user'
  delete  'logout'                => 'users#logout'
  

  # Restricted Functions

  # put     'account'             => 'requests#request_admin'
  # post    'admin_users'         => 'requests#accept_request'
  # delete  'admin_users'         => 'requests#delete_request'


  # Admin functions
  get     'admin_home'            => 'admin#index'
  get     'admin_users'           => 'admin#users'
  get     'admin_edit_users'      => 'admin#edit'
  put     'admin_edit_users'      => 'admin#update'
  delete  'delete_users'          => 'admin#destroy'


  # Create defualt rail routes
  resources :users do 
    member do
      get 'account'
    end
  end

  resources :posts, except: [:show]
  resources :comments, only: [:create, :destroy, :new]
  resources :requests, only: [:create, :destroy, :edit, :new]


  # If no page exists, redirect to root
  get '*a' => redirect("/")

  
end