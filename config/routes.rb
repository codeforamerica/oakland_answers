Oaklandanswers::Application.routes.draw do
  get "category/index"
  post "search/reindex_articles", to: "search#reindex_articles"

  resources :articles

  resources :categories
  root to: "home#index"

  get '/about', to: "home#about" , as: :about
  match '/search/', to: "search#index" , as: :search, via: [:get, :post]
  get 'autocomplete', to: "search#autocomplete"
end
