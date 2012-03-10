$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "espresso/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "espresso_blog"
  s.version     = Espresso::VERSION
  s.authors     = ["Jens Krämer"]
  s.email       = ["jk@jkraemer.net"]
  s.homepage    = "http://github.com/jkraemer/espresso"
  s.summary     = "Rails 3 kiss blog engine"
  s.description = "TODO: Description of Espresso."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails",                      "~> 3.2.2"
  s.add_dependency "jquery-rails"
  s.add_dependency 'bcrypt-ruby',                '~> 3.0.0'
  s.add_dependency 'twitter_bootstrap_form_for', '~> 1.0.5'
  s.add_dependency 'rdiscount',                  '~> 1.6.8'

  s.add_development_dependency "sqlite3"
  s.add_development_dependency 'faker',              '~> 1.0.1'
  s.add_development_dependency 'rails3-generators',  '~> 0.17'
  s.add_development_dependency 'factory_girl_rails', '~> 1.7.0'
end
