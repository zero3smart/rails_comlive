class CreateCustomUnits < ActiveRecord::Migration[5.0]
  def change
    create_table :custom_units do |t|
      t.string :property
      t.string :uom
      t.integer :visibility, default: 0
      t.references :app, foreign_key: true

      t.timestamps
    end
  end
end