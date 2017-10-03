Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    devise_scope :user do
      root to: "apps#index"
    end
  end

  unauthenticated do
    devise_scope :user do
      root to: "welcome#landing"
    end
  end

  resources :apps do
    resources :brands, :standards
    resources :commodities do
      collection do
        get :autocomplete
        get :prefetch
      end
      resources :states, :specifications
      resources :packagings do
        resources :specifications
      end
    end
    resources :links, except: [:index, :show]
    resources :references
    resources :custom_units, path: "custom-units"
  end
  resources :hscode_chapters, :hscode_headings, :hscode_subheadings
  resources :unspsc_segments, :unspsc_families, :unspsc_classes, :unspsc_commodities
  resources :ownerships, :standardizations
  resources :uoms, only: [:index]

  get "/", to: "welcome#landing", as: :landing
end