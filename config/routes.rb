# config/routes.rb
Rails.application.routes.draw do
  # 1. Devise obsługuje logikę konta (rejestracja, logowanie, omniauth)
  devise_for :users, controllers: { 
    omniauth_callbacks: 'users/omniauth_callbacks', 
    registrations: 'users/registrations' 
  }

  # 2. Ograniczamy scaffold do akcji, których Devise NIE ma w standardzie.
  # Pozwalamy tylko na listę użytkowników (index) i podgląd profilu (show).
  resources :users, only: [:index, :show]

  scope "(:locale)", locale: /en|pl/ do
    root to: "users#index"
    
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
