require 'test_helper'

class BlogControllerTest < ActionController::TestCase
  setup do
    s_meta = Factory(:section, :name => 'meta')
    @imprint = Factory(:article, :section => s_meta, :title => 'Imprint', :body => 'lorem ipsum')
    @article = Factory(:article)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert assigns(:articles).any?
  end

  test "should get show" do
    get :show, :path => @article.path
    assert_response :success
    assert_equal @article, assigns(:article)
  end

end
