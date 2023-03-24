Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      member do
        post 'likes' => 'posts#likes', as: :likes
      end
      resources :comments, only: [:create, :new, :destroy, :index]
    end
  end

  namespace :api do
    namespace :v1 do
      resources :users, only: [] do
        resources :posts, only: [:index]
      end
      resources :posts, only: [] do
        resources :comments, only: [:index]
      end
    end
  end

  # http://[::1]:3000/api/v1/users/1/posts 
  # http://[::1]:3000/api/v1/posts/21/comments
  root "users#index"
end
