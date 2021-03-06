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
  get '/customer/:id/quit' => 'public/customers#quit', as: 'quit'
  # 論理削除用のルーティング
  patch '/customer/:id/withdraw' => 'public/customers#withdraw', as: 'withdraw'
  get '/search', to: 'public/searches#search', as: 'search'
  get '/genre_search', to: 'public/searches#genre_search', as: 'genre_search'

 scope module: :public do
    resources :items do
      resources :comments
    end
    resources :customers do
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
    resources :relationships
    #resources :favorites
    post '/favorites/:id' => 'favorites#create', as: 'favorit'
    delete '/favorites/:id' => 'favorites#destroy', as: 'an_favorit'
    resources :contacts, only: [:new, :create]
      post 'contacts/confirm', to: 'contacts#confirm', as: 'confirm'
      post 'contacts/back', to: 'contacts#back', as: 'back'
      get 'done', to: 'contacts#done', as: 'done'
    root to: 'homes#top'
end


namespace :admin do
    resources :items
    resources :genres
    resources :customers
    resources :homes
end

end