class CreateEspressoArticles < ActiveRecord::Migration
  def change
    create_table :espresso_articles do |t|
      t.string :title
      t.string :slug
      t.string :path, :length => 1024
      t.text :body
      t.text :body_html
      t.datetime :published_at
      t.integer :section_id

      t.timestamps
    end
    add_index :espresso_articles, :path
  end
end
