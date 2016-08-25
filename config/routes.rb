Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "oauth" }
  devise_scope :user do
    get "/logout" => "devise/sessions#destroy", as: :destroy_user_session
  end

  resource :quiz, only: [:show]
  resource :setup do
    member do
      get :no_org
    end
  end

  resources :answers, only: [:create]

  get "/auth/:provider/callback" => "oauth#create"

  root 'quiz#show'

  namespace :admin do
    resources :people, only: [:index]
  end
end
