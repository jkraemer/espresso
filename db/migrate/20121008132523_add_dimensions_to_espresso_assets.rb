class AddDimensionsToEspressoAssets < ActiveRecord::Migration
  def change
    add_column :espresso_assets, :width, :integer

    add_column :espresso_assets, :height, :integer

  end
end
