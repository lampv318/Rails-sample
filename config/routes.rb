Rails.application.routes.draw do
  scope "(:locale)", :locale => /en|vi/ do
    root "pages#home"
    get "/*page" => "pages#show"
  end
end
