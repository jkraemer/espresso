# Read about factories at https://github.com/thoughtbot/factory_girl


FactoryGirl.define do

  sequence :title do |n|
    "Article #{n}"
  end

  factory :article, :class => Espresso::Article do
    title { FactoryGirl.generate :title }
    body "MyText"
    published_at "2012-03-10 17:17:22"
    section { Espresso::Section.root }
  end

end
