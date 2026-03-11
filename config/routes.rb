# config/routes.rb
Rails.application.routes.draw do

  devise_for :users, controllers: { 
    omniauth_callbacks: 'users/omniauth_callbacks', 
    registrations: 'users/registrations' 
  }
  
  scope "(:locale)", locale: /en|pl/ do
    root to: "users#index"
    
    resources :users, only: [:index, :show]

    resources :posts do
      resources :comments, only: [:create, :destroy] do
        collection do
          get :sort
        end
      end
    end

    get "up" => "rails/health#show", as: :rails_health_check
  end
end
