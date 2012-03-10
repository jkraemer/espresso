module Espresso
  class Engine < ::Rails::Engine
    isolate_namespace Espresso

    config.generators do |g|
      g.test_framework  :test_unit, :fixture => true, :fixture_replacement => :factory_girl
    end
  end
end
