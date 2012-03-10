DB setup
========

rake espresso:install:migrations
rake db:migrate


Mounting the engine
===================

mount Espresso::Engine => "/espresso"


Authentication
==============

You have to implement it by yourself.

For simple setups securing the /espresso namespace with http based authenticatoin
might be enough. For more complex setups where you want to do authentication across multiple
rack apps you might consider using warden. See http://ryanfunduk.com/shared-auth-for-rack-apps/
for an example.

