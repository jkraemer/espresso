require 'test_helper'

module Espresso
  class ArticlesControllerTest < ActionController::TestCase

    setup do
      @article = Factory(:article)
    end

    test "should get index" do
      get :index
      assert_response :success
      assert assigns(:articles).any?
    end

    test "should get new" do
      get :new
      assert_response :success
      assert assigns(:article).new_record?
    end

    test "should get show" do
      get :show, :id => @article.id
      assert_response :success
      assert_equal(@article, assigns(:article))
    end

    test "should get edit" do
      get :edit, :id => @article.id
      assert_response :success
      assert_equal(@article, assigns(:article))
    end

    test 'should update article' do
      post :update, :id => @article.id, :article => { :title => 'new title' }
      assert_redirected_to articles_path
      @article.reload
      assert_equal('new title', @article.title)
    end

    test 'should create article' do
      assert_difference "Article.count", 1 do
        post :create, :article => { :title => 'title', :body => 'body text' }
      end
      assert_redirected_to articles_path
    end

    test 'should destroy article' do
      assert_difference "Article.count", -1 do
        delete :destroy, :id => @article.id
      end
      assert_redirected_to articles_path
    end

  end
end
