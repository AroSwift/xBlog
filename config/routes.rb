Rails.application.routes.draw do
  # rake routes

  root 'users#index'

  # Regular functions
  get     'login'                 => 'users#login'
  post    'login_user'            => 'users#login_user'
  delete  'logout'                => 'users#logout'

  # Admin functions
  # => # => # =>  ADD THESE TO THE USERS RESOURCE
  get     'admin_home'            => 'admin#index'
  get     'admin_users'           => 'admin#users'

  # Create defualt rail routes
  resources :users do 
    member do
      get 'account'
    end
  end

  resources :posts
  resources :comments, only: [:create, :destroy, :new, :index]
  resources :requests, only: [:create, :destroy, :update, :edit, :new]


  # If no page exists, redirect to root
  get '*a' => redirect("/")

  
end