require 'test_helper'

module Espresso
  class ArticleTest < ActiveSupport::TestCase

    test 'should ensure path uniqueness' do
      s = Factory(:section)
      root_article = Factory(:article, :section => Section.root, :title => 'My Title')
      a1 = Factory.build(:article, :section => s, :title => 'My Article')
      assert a1.save
      a2 = Factory.build :article, :section => s, :title => 'My Article'
      assert !a2.save, 'should check uniqueness of path'
      assert a2.errors[:path]
    end

    test 'should update taggings on save' do
      assert_difference "Tag.count", 2 do
        a = Factory(:article, :tag_names => 'foo, bar')
      end

      assert_difference "Tag.count", 1 do
        Factory(:article, :tag_names => 'foo, another tag')
      end

      assert tags = Espresso::Tag.all
      assert_equal(3, tags.size)
      assert Espresso::Tag.find_by_name('another tag')
    end

  end
end
