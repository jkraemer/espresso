class CreateEspressoArticles < ActiveRecord::Migration
  def change
    create_table :espresso_articles do |t|
      t.string :title
      t.string :slug
      t.text :body
      t.text :body_html
      t.datetime :published_at
      t.integer :section_id

      t.timestamps
    end
  end
end
