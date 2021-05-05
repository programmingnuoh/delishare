Rails.application.routes.draw do
  devise_for :users
  root to: "delis#index"
  resources :users, only: [:new, :create, :show, :edit, :update]
  resources :delis do
    member do
      get 'confirm', action: :confirm, as: :confirm
    end
  end
end
