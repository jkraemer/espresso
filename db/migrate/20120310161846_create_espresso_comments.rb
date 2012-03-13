class CreateEspressoComments < ActiveRecord::Migration
  def change
    create_table :espresso_comments do |t|
      t.string :author_name
      t.string :author_url
      t.string :author_email
      t.string :author_ip
      t.text :body
      t.text :body_html
      t.integer :article_id
      t.boolean :approved

      t.timestamps
    end

    add_index :espresso_comments, :article_id
  end
end
