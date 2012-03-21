require 'test_helper'

module Espresso
  class IconsControllerTest < ActionController::TestCase
    test "should fetch icon" do
      get :show, :ctype => 'text/html', :size => 50
      assert_response :success
      assert_equal 'image/png', @response.content_type
    end
  end
end
