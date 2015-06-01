Rails.application.routes.draw do
  root 'welcome#index'

  get     'login'   => 'sessions#login'
  post    'login'   => 'sessions#create'
  delete  'logout'  => 'sessions#destroy'

  get     'signup'  => 'welcome#signup'
  get     'home'    => 'welcome#index'
  get     'post'    => 'welcome#post'
  get     'post'    => 'welcome#post'

  resources :users
  resources :sessions
end