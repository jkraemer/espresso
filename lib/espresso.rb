require "espresso/engine"
require "espresso/configuration"
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
