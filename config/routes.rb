Espresso::Engine.routes.draw do

  resources :sections, :except => :show

  resources :articles do
    member do
      put :publish
    end
  end
  root :to => 'articles#index'
end
