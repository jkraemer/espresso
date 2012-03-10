class CreateEspressoComments < ActiveRecord::Migration
  def change
    create_table :espresso_comments do |t|
      t.string :name
      t.string :url
      t.text :body
      t.integer :article_id

      t.timestamps
    end

    add_index :espresso_comments, :article_id
  end
end
