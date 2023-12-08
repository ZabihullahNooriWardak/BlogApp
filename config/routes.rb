Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  get 'users', to: 'users#index', as: :users  
  get 'users/:id', to: 'users#show', as: :user 

  get 'users/:user_id/posts', to: 'posts#index', as: :user_posts  
  get 'posts/:id', to: 'posts#show', as: :user_post               
end