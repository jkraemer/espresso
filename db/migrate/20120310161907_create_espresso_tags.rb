class CreateEspressoTags < ActiveRecord::Migration
  def change
    create_table :espresso_tags do |t|
      t.string :name
    end

    create_table :espresso_taggings do |t|
      t.integer :tag_id
      t.integer :article_id
    end

    add_index :espresso_taggings, :tag_id
    add_index :espresso_taggings, :article_id
  end
end
