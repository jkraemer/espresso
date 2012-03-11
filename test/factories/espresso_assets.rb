# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :asset, :class => Espresso::Asset do
      file File.new("test/files/image.jpg")
      title "My Asset"
    end
end
