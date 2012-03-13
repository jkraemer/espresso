Rails.application.routes.draw do
  mount Espresso::Engine => "/espresso"

  match "comments/*path" => 'blog#create_comment', :as => :create_article_comment, :via => :post
  match "*path" => 'blog#show', :as => :article

  root :to => 'blog#index'
end
