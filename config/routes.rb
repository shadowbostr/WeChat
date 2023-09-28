Rails.application.routes.draw do


root to: 'users#index'
get '/search', to: 'users#index'

post '/conversations/create_conversation/:user_id', to: 'conversations#create_conversation', as: 'chat'




  resources :conversations, only: [:show] do
    resources :messages, only: [ :create, :destroy ]
  end



  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
