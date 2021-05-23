Rails.application.routes.draw do
  devise_for :users
  root to: "delis#index"
  resources :users, only: [:show, :edit, :update]
  resources :delis do
    member do
      get 'confirm'
    end
    collection do
      get 'search'
    end
  end
end
