Rails.application.routes.draw do
  get 'sessions/new'
  resources :pictures
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end