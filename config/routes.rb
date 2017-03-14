Rails.application.routes.draw do
  root 'page#top'
  get 'page/info'
  get 'page/contact'

  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }

  resources :users, shallow: true do
    resources :addresses
    resources :wish_lists
    resources :books, except: [:edit]
  end

  resources :books do
    resources :wishes, only: [:show, :create]
    resources :book_addresses, only: [:create]
    resources :evals, only: [:create]
  end

  resources :wishes, only: [:update, :destroy], shallow: true do
    resources :replies, only: [:create, :update, :destroy]
  end

  resources :items, only: [:index]
end
