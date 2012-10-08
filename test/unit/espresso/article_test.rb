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

    test "should find articles tagged with" do
      assert_difference "Espresso::Tag.count", 3 do
        a1 = Factory(:article, :tag_names => 'foo, bar')
        a2 = Factory(:article, :title => 'some other article', :tag_names => 'foo, baz')
      end

      assert_equal(2, Article.tagged_with('foo').size)
      assert_equal(1, Article.tagged_with('bar').size)
      assert_equal(1, Article.tagged_with('foo', 'bar').size)
      assert_equal(0, Article.tagged_with('baz', 'bar').size)
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

    test "updating a published article should not update the publish date" do
      s = Factory(:section)
      a = Factory(:article, :section => s, :title => 'test 1')
      assert a.save
      assert a.publish!
      a = Article.find a.id
      assert a.published?
      a.update_attribute :published_at, 5.minutes.ago
      assert d = a.published_at
      a.update_attributes :title => 'new title'

      a = Article.find a.id
      assert_equal(d, a.published_at)
    end

  end
end
