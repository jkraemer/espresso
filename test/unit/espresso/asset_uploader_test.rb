require 'test_helper'

module Espresso
  class AssetUploaderTest < ActiveSupport::TestCase
    setup do
      @asset = Factory(:asset)
      AssetUploader.enable_processing = true
      @uploader = AssetUploader.new(@asset, :file)
    end

    teardown do
      AssetUploader.enable_processing = false
      @uploader.remove!
    end

    test 'should create thumbnail' do
      @uploader.store!(File.open('test/files/image.jpg'))
      assert_image_dimensions @uploader.thumb, 50, 50
    end

    test 'should create medium version' do
      @uploader.store!(File.open('test/files/image.jpg'))
      assert_bounding_box @uploader.medium, 400, 300
    end
  end
end
