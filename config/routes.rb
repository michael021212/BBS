Rails.application.routes.draw do
  root to: 'posts#index'
  get 'categories/index'

  devise_for :users

  resources :posts, except: %i[edit update destroy] do
    resource :comments, only: %i[create]
  end

  resource :posts do
    resources :categories, only: %i[show]
  end
end
