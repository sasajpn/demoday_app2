Rails.application.routes.draw do
  root 'page#top'
  devise_for :users
end
