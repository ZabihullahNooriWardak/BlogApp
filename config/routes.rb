Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  resources :users, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    resources :posts, only: [:index, :show, :new, :create, :edit, :update, :destroy], shallow: true do
      resources :comments, only: [:new, :create]
    end
  end

  resources :posts, only: [] do
    resources :likes, only: [:create]
  end

  root 'users#index'
end
