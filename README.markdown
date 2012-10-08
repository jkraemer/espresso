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


Serving Images at arbitrary resolutions
---------------------------------------

While thumbnail creation for the backend happens when images are uploaded, you
most certainly want to serve images to your visitors at other resolutions, maybe
even supporting retina displays with high resolution images. Luckily,
Espresso's Asset class includes support for scaling images on the fly to any
resolution you see fit.

To make use of that, create a controller for serving your images like that:


    class PhotosController < ApplicationController
      caches_page :show # you dont want to scale images on every request...

      def show
        @asset = Espresso::Asset.find params[:id]
        raise ActiveRecord::RecordNotFound unless @asset.image?

        width = params[:width].to_i
        height = params[:height].to_i
        quality = 85

        # handle retina requests
        if params[:name] =~ /_2x$/
          width = width * 2
          height = height * 2
          quality = 50 # keep file size reasonable. at high resolutions compression artifacts don't do that much harm.
        end

        send_data @asset.scale_to(width, (height == 0 ? nil : height), :quality => quality),
                  :disposition => 'inline',
                  :type => 'image/jpeg'
      end
    end


And add a corresponding route:

    match 'photos/:width/:height/:id/:name' => 'photos#show', :as => 'photo', :via => :get


Note that the name parameter is only used once - when we check wether it ends
with `_2x` which will trigger delivery of the asset with twice the dimensions
given by width and height. So you can put any name you want there - and even
add the `_2x` prefix automatically via some clever combination of JavaScript,
Cookies and Rewrite Rules, as described at
http://www.teamdf.com/web/automatically-serve-retina-artwork/191/ for example.
Or choose to use another routing scheme and maybe append the retina postfix to
the id, skipping the :name argument alltogether.


A helper method for generating image tags programmatically might also come in handy:

    def photo_tag(asset, width = asset.width, height = nil)
      height ||= asset.scaled_height_keeping_aspect_ratio(width)
      image_tag photo_path(:id => asset.id, :width => width, :height => height, :name => asset.filename), :width => width, :height => height, :alt => asset.title
    end


Et voila, a request to

    /photos/300/200/5/foobar_2x.jpg

will in fact devliver a 600x400 image, while

    /photos/300/200/5/foobar.jpg

will deliver the same image, but at a scale of 300x200.



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

With nginx in a reverse proxy setup you may use something in the lines
of:

     location ~ ^/espresso/icons/ {
         expires max;
         try_files $uri.png @proxy;
     }

     location @proxy {
         proxy_pass http://your-upstream;
     }


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

