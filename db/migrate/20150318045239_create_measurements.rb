class CreateMeasurements < ActiveRecord::Migration
  def change
    create_table :measurements do |t|
      t.string :type
      t.decimal :data
      t.references :plant, index: true

      t.timestamps
    end
  end
end
