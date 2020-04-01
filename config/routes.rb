Rails.application.routes.draw do
  root to: 'posts#index'
  post '/posts/:id', to: 'comments#create'

  devise_for :users

  resources :posts, except: %i[edit update destroy]

  resource :posts, except: %i[new edit show update destroy create] do
    resources :categories, only: %i[show]
  end
end
