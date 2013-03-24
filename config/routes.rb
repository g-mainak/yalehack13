Yalehack13::Application.routes.draw do
  resources :users
  resources :projects
  resources :comments

  get 'tags/:tag', to: 'projects#index', as: :tag
  get 'interests/:interest', to: 'users#index', as: :interest
  get '/login', :to => 'sessions#new', :as => :login
  put "project/:project_id/" => "project#incHelpful"
  match '/comments', :to => "comments#create"
  match '/projects/comment', :to => "projects#comment"
  match '/fbshare', :to => 'projects#fbshare'
  match "/promote" => "projects#promote"
  match '/search', :to => 'static_pages#search'
  match '/signin', to: 'sessions#new'
  match '/signup', to: 'users#new'

  # omniauth routes
  match '/auth/:provider/callback' => 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match "/signout" => "sessions#destroy", :as => :signout

  root :to => 'static_pages#home'
end