Rails.application.routes.draw do
#会員側
devise_for :customers, skip: :all
devise_scope :customer do
  get 'customers/sign_in' => 'customers/sessions#new', as: 'new_customer_session'
  post 'customers/sign_in' => 'customers/sessions#create', as: 'customer_session'
  delete 'customers/sign_out' => 'customers/sessions#destroy', as: 'destroy_customer_session'
  get 'customers/sign_up' => 'customers/registrations#new', as: 'new_customer_registration'
  post 'customers' => 'customers/registrations#create', as: 'customer_registration'
  get 'customers/password/new' => 'customers/passwords#new', as: 'new_customer_password'
end
  
devise_for :admins, skip: :all
devise_scope :admin do
  get 'admins/sign_in' => 'admins/sessions#new', as: 'new_admin_session'
  post 'admins/sign_in' => 'admins/sessions#create', as: 'admin_session'
  delete 'admins/sign_out' => 'admins/sessions#destroy', as: 'destroy_admin_session'
end
  
get 'relationships/create'
get 'relationships/destroy'
  
resources :customers do
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
end

#devise_for :customers, controllers: {
        #sessions: 'customers/sessions',
        #passwords: 'customers/passwords',
        #registrations: 'customers/registrations'
    #}

  get 'homes/top'
  root to: 'homes#top'
  get 'home/about' => 'homes#about'
  resources :items
  resources :customers

  resources :item, only: [:new, :create, :index, :show, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
    resource :relationships, only: [:create, :destroy]
  end

  # 退会確認画面
  get '/customer/:id/quit' => 'customers#quit', as: 'quit'
  # 論理削除用のルーティング
  patch '/customer/:id/withdraw' => 'customers#withdraw', as: 'withdraw'

  get 'search/search'
  get '/search', to: 'search#search'

namespace :Public do
    resources :items
    resources :comments
    resources :customers
    resources :favorites
    resources :homes
    resources :relationships
    resources :searchs
end

namespace :admin do
    resources :items
    resources :genres
    resources :customers
end



#devise_for :admins, controllers: {
    #sessions: 'admins/sessions',
    #passwords: 'admins/passwords',
    #registrations: 'admins/registrations'
#}

end
end