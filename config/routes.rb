Rails.application.routes.draw do
  root 'mangas#index'
  resources :mangas, only: %i(index)
  # root to: 'books#index'
  resources :books
  devise_for :users
end
