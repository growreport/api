class AddUserToPlant < ActiveRecord::Migration
  def change
    add_reference :plants, :user, index: true
  end
end
