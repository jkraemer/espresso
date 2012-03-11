require 'test_helper'

module Espresso
  class AssetsControllerTest < ActionController::TestCase
    setup do
      @asset = Factory(:asset)
    end

    test "should get index" do
      get :index
      assert_response :success
      assert assigns(:assets).any?
    end

    test 'should create asset' do
      assert_difference "Asset.count", 1 do
        post :create, :asset => { :title => 'new asset',
                                  :file => fixture_file_upload('../../../files/image.jpg', 'image/jpeg') }
      end
      assert_redirected_to '/espresso/assets'
      assert a = Asset.find_by_title('new asset')
      assert_equal File.size('test/files/image.jpg'), a.file_size
    end

    test "should get edit" do
      get :edit, :id => @asset.id
      assert_response :success
      assert_equal(@asset, assigns(:asset))
    end

    test 'should update asset' do
      put :update, :id => @asset.id, :asset => { :title => 'new title' }
      assert_redirected_to '/espresso/assets'
      @asset.reload
      assert_equal('new title', @asset.title)
    end

    test 'should destroy asset' do
      assert_difference "Asset.count", -1 do
        delete :destroy, :id => @asset.id
      end
      assert_redirected_to '/espresso/assets'
    end

  end
end
