Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    devise_scope :user do
      root to: "apps#index"
    end
  end

  unauthenticated do
    devise_scope :user do
      root to: "devise/sessions#new"
    end
  end

  resources :apps do
    resources :commodities
    resources :links
    resources :references
    resources :measurements
    resources :custom_units, path: "custom-units"
  end
  resources :uoms, only: [:index]
end
