class DropStrainsTechniques < ActiveRecord::Migration
  def change
    drop_table :strains 
    drop_table :techniques 

    add_column :plants, :strain, :string
    add_column :plants, :technique, :string
  end
end
