# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :section, :class => Espresso::Section do
    name "section 1"
    parent { Espresso::Section.root }
  end

end
