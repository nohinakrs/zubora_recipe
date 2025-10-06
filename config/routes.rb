Rails.application.routes.draw do
  get 'homes/index'
  get 'about', to: "homes#about", as: "about"
  devise_for :users
  resources :recipes, only:[:edit, :index, :show, :destroy]
  resources :users, only:[:edit, :show, :update]
  root to: "homes#top"
end
