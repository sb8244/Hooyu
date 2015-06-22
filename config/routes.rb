Rails.application.routes.draw do
  resource :quiz, only: [:show]
  resources :answers, only: [:create]

  root 'quiz#show'
end
