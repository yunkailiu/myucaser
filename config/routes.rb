Rails.application.routes.draw do

  root 'pages#home'
  
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'

  devise_for :users,
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  path: '',
  path_names: {sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'registration'}, 
  controllers: {registrations: 'registrations'}
  
  resources :users, only: [:show]
end
