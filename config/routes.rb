Rails.application.routes.draw do
 # devise_for :admins
  root to: 'homes#top'
  devise_for :users
   devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
 }

  resources :recipes, only:[:edit, :create, :new, :index, :show, :update, :destroy] do
    resources :comments, only: [:create, :destroy]
  end
  resources :users, only:[:edit, :show, :update]
  get "about" => "homes#about", as: "about"
  # 検索機能のパス
  get '/search', to: 'searches#search'
  # 退会確認画面
  get '/users/:id/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
  # 論理削除用のルーティング
  patch '/users/:id/withdrawal' => 'users#withdrawal', as: 'withdrawal'
end
