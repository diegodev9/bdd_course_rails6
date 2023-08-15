Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  get 'articles/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'articles#index'

  resources :articles do
    resources :comments
  end

  # mount ActionCable.server => '/cable'
end
