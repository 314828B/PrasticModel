Rails.application.routes.draw do

devise_for :customers, controllers: {  #会員側
        sessions: 'public/devise/sessions',
        passwords: 'public/devise/passwords',
        registrations: 'public/devise/registrations'
      }

devise_for :admins, controllers: {     #管理者側
        sessions: 'admin/devise/sessions',
        passwords: 'admin/devise/passwords',
        registrations: 'admin/devise/registrations'
      }

  #root to: 'public/homes#top'

  # resources :items do
  #   resource :favorites, only: [:create, :destroy]
  #   resources :comments, only: [:create, :destroy]
  #   resource :relationships, only: [:create, :destroy]
  # end
  #resources :customers


  # 退会確認画面
  get '/customer/:id/quit' => 'customers#quit', as: 'quit'
  # 論理削除用のルーティング
  patch '/customer/:id/withdraw' => 'customers#withdraw', as: 'withdraw'
  get 'serch/serch'
  get '/serch', to: 'serch#serch'

 scope module: :public do
    resources :items
    resources :customers do
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
    resources :comments
    resources :relationships
    resources :favorites
    root to: 'homes#top'
end


namespace :admin do
    resources :items
    resources :genres
    resources :customers
    resources :homes
end

end