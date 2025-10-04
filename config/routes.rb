Rails.application.routes.draw do
  get 'homes/index'
  get 'homes/about'
  devise_for :users
  resources :recipes, only:[:edit, :index, :show]
  resources :users, only:[:edit, :show]
  root to: "homes#top"
end
