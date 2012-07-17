Espresso::Engine.routes.draw do

  resources :assets do
    collection { get :thumbnails }
  end
  resources :sections, :except => :show

  resources :articles do
    member { put :publish }
  end

  match 'icons/*ctype/:size' => 'icons#show', :as => 'icon', :constraints => { :size => /\d+/ }

  root :to => 'articles#index'
end
