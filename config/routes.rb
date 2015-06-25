Rails.application.routes.draw do
  # bundle exec rake routes

  root 'users#index'

  # Regular functions
  #get     'home'                => 'users#index'
  get     'signup'              => 'users#signup'
  #post    'signup'              => 'users#create'
  get     'login'               => 'users#login'
  #post    'login'               => 'users#show'
  delete  'logout'              => 'users#logout'
  

  # Restricted Functions
  # get     'post'                => 'posts#post'
  # post    'post'                => 'posts#create'  
  # delete  'post'                => 'posts#destroy'
  # put     'edit_post'           => 'posts#update'
  # get     'edit_post'           => 'posts#edit_post'

  # post    'comment'             => 'comments#create'
  # delete  'comment'             => 'comments#destroy'

  put     'account'             => 'requests#request_admin'
  post    'admin_users'         => 'requests#accept_request'
  delete  'admin_users'         => 'requests#delete_request'

  # Admin functions
  get     'admin_home'          => 'admin#index'
  get     'admin_users'         => 'admin#users'
  get     'admin_edit_users'    => 'admin#edit_users'
  put     'admin_edit_users'    => 'admin#update'
  delete  'admin_logout'        => 'admin#logout'
  delete  'delete_users'        => 'admin#destroy'


  resources :users do 
    member do
      get 'account'
      get 'login'
    end
  end

  resources :posts
  # literally creates
  #/posts/:id/create
  #/posts/:id/edit
  # etc.
  
  #resources :admin



  # If no page exists, redirect to home
  get '*a' => redirect("/")

  
end