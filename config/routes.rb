Rails.application.routes.draw do
  root 'welcome#index'

  get     'login'   => 'sessions#login'
  post    'login'   => 'sessions#create'
  get     'logout'  => 'sessions#logout'
  delete  'logout'  => 'sessions#destroy'

  get     'index'   => 'users#signup'
  get     'signup'  => 'users#signup'
  post    'signup'  => 'users#create'
  get     'home'    => 'welcome#index'
  get     'post'    => 'welcome#post'
  get     'post'    => 'welcome#post'

  resources :users
  resources :sessions
end