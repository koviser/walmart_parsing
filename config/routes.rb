Rails.application.routes.draw do
  root 'products#index'

  resources :products, only: %w[index show]
  resources :reviews, only: %w[index show]

  namespace :api do
    # Methods for json response
    namespace :private do
      resources :products, only: %w[index create] do
        get :reviews
      end
    end
  end
end
