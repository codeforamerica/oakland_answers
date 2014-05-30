Oaklandanswers::Application.routes.draw do
  get "quick_answer/show"

  get "category/index"
  post "search/reindex_articles", to: "search#reindex_articles"

  ActiveAdmin.routes(self)

  devise_for :users, :controllers => { :sessions => "sessions" }

  resources :contacts

  resources :articles

  resources :categories

  resources :guides

  resources :web_services

  resources :quick_answers
  root :to => "home#index"

  match '/about' => "home#about" , :as => :about
  match '/search/' => "search#index" , :as => :search, :via => [:get, :post]
  match 'autocomplete' => "search#autocomplete"
  match '/articles/article-type/:content_type' => "articles#article_type", as: :articles_type
end
