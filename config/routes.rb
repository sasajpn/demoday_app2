Rails.application.routes.draw do
  root 'page#top'
  devise_for :users

  resources :users do
    resources :addresses
    resources :books, shallow: true do
      resources :evals
      resources :negotiates do
        resources :trades
      end
    end
  end
  resources :deals, only: [:index]
end
