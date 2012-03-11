require 'test_helper'

module Espresso
  class SectionsControllerTest < ActionController::TestCase
    setup do
      Section.root
      @s = Factory(:section)
    end

    test "should get index" do
      get :index
      assert_response :success
      assert assigns(:sections).any?
    end

    test "should get edit" do
      get :edit, :id => @s.id
      assert_response :success
      assert_equal(@s, assigns(:section))
    end

    test "should get new" do
      get :new, :parent_id => @s
      assert_response :success
      assert_equal(@s.id, assigns(:section).parent_id)
    end

    test 'should create section' do
      assert_difference "Section.count", 1 do
        post :create, :section => { :name => 'new section', :parent_id => @s.id }
      end
      @s.reload
      assert_equal(1, @s.children.size)
      assert_equal('new section', @s.children.first.name)
    end

    test 'should update section' do
      put :update, :id => @s.id, :section => {:name => 'new name'}
      assert_redirected_to sections_path
      @s.reload
      assert_equal('new name', @s.name)
      assert_equal('new-name', @s.slug)
    end


  end
end
