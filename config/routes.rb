Rails.application.routes.draw do
  get 'donations/new'
  get 'sessions/new'
  get 'users/new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/signup', to:'users#new'
  resources :users
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/campaigns', to: 'campaigns#show'
  get 'campaign', to: 'campaigns#show'
  get 'users/:user_id/campaigns/:campaign_id', to: 'campaigns#donations', as: 'my_donations'
  patch 'users/:user_id/campaigns/:campaign_id', to: 'donations#new', as: 'create_donations'
  patch 'users/:user_id/campaigns/:campaign_id/donate', to: 'donations#create', as: 'donate'

  resources :campaigns

  resources :users do 
    member do
      get :donations, :funds
    end
  end

  # resources :campaigns do 
  #   member do
  #     post 'donate' 
  #   end
  # end 



end
