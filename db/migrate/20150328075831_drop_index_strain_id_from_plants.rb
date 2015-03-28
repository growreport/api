class DropIndexStrainIdFromPlants < ActiveRecord::Migration
  def change
    remove_index :plants, name: "index_plants_on_strain_id"
    remove_column :plants, :strain_id, :integer
  end
end
