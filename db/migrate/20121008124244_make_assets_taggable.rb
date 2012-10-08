class MakeAssetsTaggable < ActiveRecord::Migration
  def up
    add_column :espresso_taggings, :taggable_type, :string
    add_column :espresso_taggings, :taggable_id, :integer
    execute "update espresso_taggings set taggable_type='Espresso::Article', taggable_id=article_id"
    remove_column :espresso_taggings, :article_id
  end

  def down
    add_column :espresso_taggings, :article_id, :integer
    execute "update espresso_taggings set article_id=taggable_id where taggable_type='Espresso::Article'"
    remove_column :espresso_taggings, :taggable_type
    remove_column :espresso_taggings, :taggable_id
  end

end
