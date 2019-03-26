Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'hataposts/:id', to: 'hataposts#update'
  
  get 'signup', to: 'users#new'
  
  resources :users do
    member do
      get :followings
      get :followers
      get :likes
    end 
  end 
  
  resources :hataposts, only: [:create, :destroy, :edit, :update]
  resources :relationships, only: [:create, :destroy]
  resources :liked_posts, only: [:create, :destroy]
end 
  

