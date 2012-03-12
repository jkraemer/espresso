Rails.application.routes.draw do


  mount Espresso::Engine => "/espresso"

  match "*path" => 'blog#show', :as => :article
  root :to => 'blog#index'
end
