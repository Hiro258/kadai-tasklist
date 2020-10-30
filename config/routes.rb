Rails.application.routes.draw do

  root to: 'tasks#index'
  
  get 'login', to: 'sessions#new'
 
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'signup', to: 'users#new'
   
  resources :tasks

#【学習メモ】指摘対応。使用してないアクションの指定は無駄。
#resources :users, only: [:index, :show, :new, :create]

resources :users, only: [:new, :create]

end
