About
=====

Espresso is a Rails engine, implementing basic content and asset
management. It's main purpose is to serve as the backend of Blogs and
other sites consisting of sections, articles, lists of articles, and an
image here and there.

Why?
----

Because I can ;)

I wanted a simple and easy to use backend for my blog, and the idea of
building that and only that into an engine, leaving me and possibly
other people complete freedom when it comes to implementing the frontend
and / or the remaining pieces of the site in question sounded like an
interesting experiment.

Features
--------

- CRUD for Articles and Sections
- Sections may contain sub-sections
- uses Discount for markdown rendering
- Asset management with automatic scaling of images and Drag & Drop
  support for up- and downloading assets.
- No built-in authentication. I consider that a feature because that way
  you can use whatever authentication scheme you like in your app. Since
  you most likely don't want everybody posting stuff on your site, be sure
  to read the corresponding section below.


Usage and Customization
=======================

First, add espresso_engine to your Gemfile and run the bundle command to
install it.

DB setup
--------

In order to create the needed tables, run

    rake espresso_engine:install:migrations
    rake db:migrate

in your Rails project.

Routes
------

put

    mount Espresso::Engine => "/espresso"

into your routes.rb

Using Espresso's content in your application
--------------------------------------------

The test application located in test/dummy in Espresso's sources
implements a basic blog frontend on top of Espresso. There's only one
controller and some views involved, so be sure to take a look at it to
get an idea of how to make best use of what Espresso offers.

Backend: Pagination
-------------------

Espresso uses the kaminari gem for pagination. To customize pagination,
run 

    rails g kaminari:config

and edit the generated file in config/initializers/. Refer to Kaminari's
documentation at https://github.com/amatsuda/kaminari for more info.

Backend: Icons for non-Image assets
-----------------------------------

The icons for assets that are no images are retrieved from stdicon.com,
which unfortunately is http-only. In order to prevent security warnings
when accessing your backend via https, the icons are proxied and
page-cached by Espresso's icons_controller. In order to take advantage
of the page-caching you have to tell your web server to serve up \*.png
files when a file without extension is requested:

    request: /icons/text/html/120
    file served: Rails.root/public/icons/text/html/120.png


Authentication
==============

Authentication is out of Espresso's scope, therefore you have to implement
it by yourself.

For simple setups, like a single-user blog you only need to secure the
/espresso namespace (or wherever you mounted the engine). In this case,
http based authentication, implemented in your web server, might be
enough.

For more complex setups where you want to do authentication across
multiple rack apps, i.e. because your application already has a way to
authenticate users, you might consider using warden. See
http://ryanfunduk.com/shared-auth-for-rack-apps/ for an example. The
popular devise gem uses warden underneath and might be a good fit for
scenarios like that.


TODO
====

- asset scaling above what is needed for the backend should be configurable
  from the main application


CREDITS
=======

- The views have been created using Twitter Bootstrap
- Neat file uploading stuff powered by jQuery File Upload Plugin
  (https://github.com/blueimp/jQuery-File-Upload)
- The twitter bootstrap kaminari pagination partials are from
  https://github.com/gabetax/twitter-bootstrap-kaminari-views
- thanks to stdicon.com for providing pretty file type icons in any size

