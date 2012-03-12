require 'test_helper'

module Espresso
  class SectionTest < ActiveSupport::TestCase

    test 'should auto-create root section' do
      root = Section.root
      assert root
      assert root.id, "root should be saved!\n#{root.errors.full_messages}"
      assert_equal('', root.slug)
      assert_equal('ROOT', root.name)
      assert_nil root.parent_id
    end

    test "should set slug upon creation" do
      assert s = Section.create!( :name => 'Section 1', :parent_id => Section.root.id )
      assert_equal('section-1', s.slug)
      assert s2 = Section.create!( :name => 'Sub Section 1 1', :parent_id => s.id )
      assert_equal('sub-section-1-1', s2.slug)
    end

    test 'root should be root' do
      assert Section.root.root?
      s = Factory(:section)
      assert !s.root?
      assert_equal Section.root, s.parent
    end

    test 'should compute path' do
      assert_equal('', Section.root.path)
      s = Factory(:section)
      assert_equal("#{s.slug}", s.path)
      s2 = Factory(:section, :parent => s)
      assert_equal("#{s.slug}/#{s2.slug}", s2.path)
    end

    test 'empty should return correct value' do
      assert Section.root.empty?
      a = Factory.build(:article)
      assert a.save, a.errors.inspect
      assert !Section.root.empty?
    end

    test 'should keep tree ordered by slug on each level' do
      s1 = Factory(:section, :name => 'h')
      s2 = Factory(:section, :name => 'z')
      s3 = Factory(:section, :name => 'c')
      assert_equal([Section.root, s3, s1, s2], Section.ordered.all)
    end
  end
end
