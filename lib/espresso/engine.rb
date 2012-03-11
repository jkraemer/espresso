module Espresso
  class Engine < ::Rails::Engine
    isolate_namespace Espresso
    engine_name 'espresso_engine'

    config.generators do |g|
      g.test_framework  :test_unit, :fixture => true, :fixture_replacement => :factory_girl
    end

    config.to_prepare do
      Espresso.config.apply!
    end
  end
end
