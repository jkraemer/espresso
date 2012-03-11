Espresso::Engine.routes.draw do

  resources :assets
  resources :sections, :except => :show

  resources :articles do
    member do
      put :publish
    end
  end

  root :to => 'articles#index'
end
