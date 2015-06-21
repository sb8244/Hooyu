Rails.application.routes.draw do
  resources :quiz, only: [:show, :create]

  root 'quiz#show'
end
