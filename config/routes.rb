Rails.application.routes.draw do
  root to: 'homes#top'
  devise_for :users

  resources :recipes, only:[:edit, :create, :new, :index, :show, :update,:destroy]
  resources :users, only:[:edit, :show, :update]
  
  get "home/about" => "homes#about", as: "about"
end
