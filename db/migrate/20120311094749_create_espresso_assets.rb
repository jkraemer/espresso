class CreateEspressoAssets < ActiveRecord::Migration
  def change
    create_table :espresso_assets do |t|
      t.string :file
      t.string :title
      t.string :content_type
      t.integer :file_size

      t.timestamps
    end
  end
end
