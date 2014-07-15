Oaklandanswers::Application.routes.draw do
  mount Bootsy::Engine => '/bootsy', as: 'bootsy'
  get "category/index"
  post "search/reindex_articles", to: "search#reindex_articles"

  resources :articles

  resources :categories
  root to: "home#index"

  get '/about', to: "home#about" , as: :about
  match '/search/', to: "search#index" , as: :search, via: [:get, :post]

  post 'persona/login' => 'persona#login'
  post 'persona/logout' => 'persona#logout'
end
