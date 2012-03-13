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

  test 'should create comment' do
    assert_difference "Espresso::Comment.count", 1 do
      post :create_comment, :path => @article.path, :comment => { :author_name => 'Anonymous coward', :body => "I'm a comment." }
    end
    assert_redirected_to "/#{@article.path}"
    @article.reload
    assert c = @article.comments.first
    assert c.author_ip
    assert_equal('Anonymous coward', c.author_name)
    assert_equal("<p>I'm a comment.</p>\n", c.body_html)
  end

end
