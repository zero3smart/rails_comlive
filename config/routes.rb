class Authenticated
  def self.matches?(request)
    request.session[:user_id].present?
  end
end

Rails.application.routes.draw do

  get "/auth/auth0/callback" => "auth0#callback"
  get "/auth/failure" => "auth0#failure"

  get "login" => "sessions#new", as: :login
  get "invitations/:token" => "invitations#accept", as: :accept_invitation
  delete "logout" => "sessions#destroy", as: :logout

  root to: "apps#index", constraints: Authenticated
  root to: "welcome#landing"

  constraints(uuid: /\d{10}/) do
    get '/brands/:uuid/:title' => 'brands#show',  as: :slugged_brand
    get '/commodities/:uuid/:title' => 'commodities#show',  as: :slugged_commodity
    get '/packagings/:uuid/:title' => 'packagings#show',  as: :slugged_packaging
    get '/standards/:uuid/:title' => 'standards#show',  as: :slugged_standard
  end

  resources :commodities do
    collection do
      get :autocomplete
      get :prefetch
    end

    resources :barcodes
  end

  resources :packagings, only: [:index]

  resources :brands, :standards

  resources :apps do
    resources :invitations, only: [:new, :create]
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