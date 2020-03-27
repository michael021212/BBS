Rails.application.routes.draw do
  root to: 'posts#index'
  # get 'posts/index'
  # get 'posts/show'
  # get 'posts/new'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts, except: %i[edit update]
end
