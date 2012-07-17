class CreateEspressoSections < ActiveRecord::Migration
  def change
    create_table :espresso_sections do |t|
      t.string :name
      t.string :slug
      t.string :path, :length => 1024
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.boolean :show_pub_date, :default => true

      t.timestamps
    end
    add_index :espresso_sections, :path
  end
end
