class CreateEspressoSections < ActiveRecord::Migration
  def change
    create_table :espresso_sections do |t|
      t.string :name
      t.string :slug
      t.integer :parent_id

      t.timestamps
    end
    add_index :espresso_sections, :slug
  end
end
