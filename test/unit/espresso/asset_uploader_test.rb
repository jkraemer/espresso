require 'test_helper'

module Espresso
  class AssetUploaderTest < ActiveSupport::TestCase
    setup do
      @asset = Factory(:asset)
      AssetUploader.enable_processing = true
      @uploader = AssetUploader.new(@asset, :file)
      @uploader.store!(File.open('test/files/image.jpg'))
    end

    teardown do
      AssetUploader.enable_processing = false
      @uploader.remove!
    end

    test 'should create thumbnail' do
      assert_image_dimensions @uploader.thumb, 50, 50
    end

    test 'should create medium version' do
      assert_bounding_box @uploader.medium, 400, 300
    end

    test "should store image dimensions" do
      assert_equal(3000, @asset.width)
      assert_equal(2000, @asset.height)
    end
  end
end
