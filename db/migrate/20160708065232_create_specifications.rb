class CreateSpecifications < ActiveRecord::Migration[5.0]
  def change
    create_table :specifications do |t|
      t.string :property
      t.decimal :value
      t.decimal :min
      t.decimal :max
      t.string :uom
      t.integer :visibility, default: 0
      t.integer :parent_id,  null: false
      t.string :parent_type, null: false

      t.timestamps
    end
  end
end