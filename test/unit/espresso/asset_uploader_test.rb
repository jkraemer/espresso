require 'test_helper'

module Espresso
  class AssetUploaderTest < ActiveSupport::TestCase
    setup do
      AssetUploader.enable_processing = true
      @asset = Asset.new
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
      assert_bounding_box @uploader.medium, 200, 200
    end
  end
end
