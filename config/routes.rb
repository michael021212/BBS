Rails.application.routes.draw do
  root to: 'posts#index'
  get 'categories/index'

  devise_for :users

  resources :posts, except: %i[edit update] do
    resource :comments, only: %i[create destroy]
  end

  resource :posts do
    resources :categories, except: %i[index]
  end
end
