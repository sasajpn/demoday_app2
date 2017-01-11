Rails.application.routes.draw do
  root 'page#top'
  devise_for :users

  resources :users do
    resources :addresses
    resources :books, shallow: true
  end
end
