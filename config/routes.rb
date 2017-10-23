Rails.application.routes.draw do

  get "/auth/auth0/callback" => "auth0#callback"
  get "/auth/failure" => "auth0#failure"
  get "/logout" => "application#logout"

  #devise_for :users, :controllers => {
  #    :invitations => 'users/invitations'
  #}

  #authenticated :user do
  #  devise_scope :user do
  #    root to: "apps#index"
  #  end
  #end

  #unauthenticated do
  #  devise_scope :user do
  root to: "welcome#landing"
  #  end
  #end

  resources :apps do
    resources :brands, :standards, :invitations
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


  # API STUFF

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :apps
    end
  end

end