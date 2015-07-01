Rails.application.routes.draw do
  # rake routes

  root 'users#index'

  # Regular functions
  get     'login'                 => 'users#login'
  post    'login_user'            => 'users#login_user'
  delete  'logout'                => 'users#logout'

  # Admin functions
  get     'admin_home'            => 'admin#index'
  get     'admin_users'           => 'admin#users'
  # delete  'delete_users'          => 'admin#destroy'
  # put     'admin_update_users'      => 'admin#update'
  # get     '/admin_edit_users/:id', to: 'admin#edit', as: 'admin_edit_users'

  # Create defualt rail routes
  resources :users do 
    member do
      get 'account'
    end
  end

  resources :posts
  resources :comments, only: [:create, :destroy, :new, :index]
  resources :requests, only: [:create, :destroy, :edit, :new]


  # If no page exists, redirect to root
  get '*a' => redirect("/")

  
end