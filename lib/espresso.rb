# work around problems with sass-rails / sprockets, see https://github.com/rails/sass-rails/issues/81
require 'sprockets'
require 'sass/rails'

require "espresso/engine"
require "espresso/configuration"
require "espresso/concerns/taggable"
require 'kaminari'
require 'twitter_bootstrap_form_for'
require 'awesome_nested_set'
require 'carrierwave'

module Espresso
  def self.config(&block)
    @@config ||= Espresso::Configuration.new
    yield @@config if block
    return @@config
  end
end
