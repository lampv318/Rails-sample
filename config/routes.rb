Rails.application.routes.draw do
  scope "(:locale)", :locale => /en|vi/ do
    root "pages#home"
    #get "/*page" => "pages#show"
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    get "/get_follow", to: "follows#show"
    post "/get_follow", to: "follows#show"
    get "/search", to: "posts#index"
    resources :users do
      resources :posts, only: [:new, :create, :index]
    end
    resources :relationships, only: [:create, :destroy]
  end
end
