class CreateHubs < ActiveRecord::Migration
  def change
    create_table :hubs do |t|
      t.string :name
      t.references :user, index: true

      t.timestamps
    end
  end
end
