Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      member do
        post 'likes' => 'posts#likes', as: :likes
      end
      resources :comments, only: [:create, :new]
    end
  end
  root "users#index"
end
