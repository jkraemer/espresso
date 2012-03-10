
Routing
=======

The engine installs routes under /blog (public) and /espresso (backend)
You may want to add a root route for the articles overview:

root :to => 'espresso/articles#index'

Assets
======

in production.rb:
config.assets.precompile += %w( espresso.css espresso.js )
