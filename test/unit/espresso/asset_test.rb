require 'test_helper'

module Espresso
  class AssetTest < ActiveSupport::TestCase

    test "should create taggings on create" do
      asset = nil
      assert_difference "Espresso::Tagging.count", 2 do
        assert_difference "Espresso::Tag.count", 2 do
          asset = Factory(:asset, :tag_names => 'foo, bar')
        end
      end
      assert a = Asset.find(asset.id)
      assert_equal(2, a.taggings.size)
      assert_equal(2, a.tags.size)
      assert_equal('foo, bar', a.tag_names)
    end

    test "should update taggings" do
      assert asset = Factory(:asset, :tag_names => 'foo, bar')
      assert_equal('foo, bar', asset.tag_names)
      assert_difference "Espresso::Tag.count", 1 do
        assert_no_difference "Espresso::Tagging.count" do
          assert asset.update_attributes(:tag_names => 'bar, baz')
        end
      end
      asset.reload
      assert_equal(2, asset.taggings.size)
      assert_equal(2, asset.tags.size)
      assert_equal('bar, baz', asset.tag_names)
    end
  end
end
