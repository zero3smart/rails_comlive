Rails.application.routes.draw do

  get "/auth/auth0/callback" => "auth0#callback"
  get "/auth/failure" => "auth0#failure"

  get "login" => "sessions#new", as: :login
  delete "logout" => "sessions#destroy", as: :logout

  root to: "apps#index", constraints: lambda { |request| request.session[:user_id].present? }
  root to: "welcome#landing"

  resources :commodities do
    resources :barcodes
  end

  resources :brands, :standards

  resources :apps do
    resources :invitations
    resources :commodity_references, path: "commodities" do
      collection do
        get :autocomplete
        get :prefetch
      end
      resources :states, :specifications
      resources :packagings do
        resources :specifications
        resources :barcodes
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

  # API STUFF

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :apps
    end
  end

end