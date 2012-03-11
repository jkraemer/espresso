Espresso::Engine.routes.draw do

  resources :assets do
    collection { get :thumbnails }
  end
  resources :sections, :except => :show

  resources :articles do
    member { put :publish }
  end

  root :to => 'articles#index'
end
