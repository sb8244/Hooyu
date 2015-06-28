Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "oauth" }

  resource :quiz, only: [:show]
  resource :setup
  resources :answers, only: [:create]

  get "/auth/:provider/callback" => "oauth#create"

  root 'quiz#show'
end
