Rails.application.routes.draw do
  # rake routes

  root 'users#index'

  # Regular functions
  get     'login'                 => 'users#login'
  post    'login_user'            => 'users#login_user'
  delete  'logout'                => 'users#logout'
  

  # Restricted Functions
  # get     'post'                => 'posts#post'
  # get     'edit_post'           => 'posts#edit_post'

  # put     'account'             => 'requests#request_admin'
  # post    'admin_users'         => 'requests#accept_request'
  # delete  'admin_users'         => 'requests#delete_request'


  # Admin functions
  get     'admin_home'            => 'admin#index'
  get     'admin_users'           => 'admin#users'
  get     'admin_edit_users'      => 'admin#edit'
  put     'admin_edit_users'      => 'admin#update'
  delete  'delete_users'          => 'admin#destroy'


  # Create defualt routes
  resources :users do 
    member do
      get 'account'
    end
  end

  # Create defualt routes
  resources :posts
  resources :comments, only: [:create, :destroy, :new]
  # resources :admin, only: [:edit, :update]


  # If no page exists, redirect to home
  get '*a' => redirect("/")

  
end