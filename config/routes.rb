Rails.application.routes.draw do
  root 'sessions#new'
  resources :pictures
  resources :users, only: [:new, :create, :show]
end
