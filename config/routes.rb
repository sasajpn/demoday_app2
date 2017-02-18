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

  resources :users do
    resources :addresses
    resources :negotiates, only: [:index]
    resources :books, except: [:edit], shallow: true do
      resources :book_addresses, only: [:create]
      resources :evals, only: [:create]
      resource :negotiate, only: [:show]
      resources :negotiates, except: [:index, :show, :edit] do
        resource :trade, only: [:show]
      end
    end
  end
  resources :deals, only: [:index]
  resources :items, only: [:index]
end
