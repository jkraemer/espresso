require 'test_helper'

class NavigationTest < ActionDispatch::IntegrationTest
  fixtures :all

  test "browse articles" do
    a1 = Factory(:article)
    a2 = Factory(:article)

    get "espresso/articles"
    assert_response :success
    assert_equal(2, assigns(:articles).size)

    get "espresso/articles/#{a1.id}"
    assert_response :success
    assert_equal(a1, assigns(:article))

    assert_match /#{a1.title}/, @response.body
    assert_match /#{a1.body}/, @response.body
  end

  test 'create article' do
    get 'espresso/articles/new'
    assert_response :success
    assert assigns(:article).new_record?

  end
end

