Rails.application.routes.draw do
  root 'posts#index'
  
  get 'chats/create'
  get 'chats/new'
  get 'chats/show'
  get 'chats/index'

  
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'

  devise_for :users, 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  path: '',
  path_names: {sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'registration'}, 
  controllers: {registrations: 'registrations'}
  
  resources :users, only: [:index, :show]
  resources :chats
  
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
  resources :posts, only: [:index, :show, :create, :destroy] do
    resources :photos, only: [:create]
    resources :likes, only: [:create, :destroy], shallow: true
    resources :comments, only: [:index, :create, :destroy], shallow: true
    resources :bookmarks, only: [:create, :destroy], shallow: true
  end
end
