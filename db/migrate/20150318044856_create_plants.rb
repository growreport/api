class CreatePlants < ActiveRecord::Migration
  def change
    create_table :plants do |t|
      t.integer :age
      t.datetime :harvest_date
      t.datetime :cure_date

      t.timestamps
    end
  end
end
