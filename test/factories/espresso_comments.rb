# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    author_name "MyString"
    author_url "MyString"
    body "MyText"
    article_id 1
  end
end
