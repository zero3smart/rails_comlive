class CreateMeasurements < ActiveRecord::Migration[5.0]
  def change
    create_table :measurements do |t|
      t.string :property
      t.decimal :value
      t.string :uom
      t.references :app, foreign_key: true

      t.timestamps
    end
  end
end
