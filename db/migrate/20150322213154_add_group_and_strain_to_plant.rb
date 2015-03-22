class AddGroupAndStrainToPlant < ActiveRecord::Migration
  def change
    add_reference :plants, :group, index: true
    add_reference :plants, :strain, index: true
  end
end
