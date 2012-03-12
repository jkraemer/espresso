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

  end
end
