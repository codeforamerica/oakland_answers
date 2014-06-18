Oaklandanswers::Application.routes.draw do
  get "quick_answer/show"

  get "category/index"
  post "search/reindex_articles", to: "search#reindex_articles"

  resources :articles

  resources :categories

  resources :quick_answers
  root to: "home#index"

  get '/about', to: "home#about" , as: :about
  match '/search/', to: "search#index" , as: :search, via: [:get, :post]
  get 'autocomplete', to: "search#autocomplete"
  get '/articles/article-type/:content_type',  to: "articles#article_type", as: :articles_type
end
