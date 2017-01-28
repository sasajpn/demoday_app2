Rails.application.routes.draw do
  root 'page#top'

  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }

  resources :users do
    resources :addresses
    resources :negotiates, only: [:index]
    resources :books, shallow: true do
      resources :evals
      resource :negotiate, only: [:show]
      resources :negotiates, except: [:index, :show] do
        resources :trades
      end
    end
  end
  resources :deals, only: [:index]
end
