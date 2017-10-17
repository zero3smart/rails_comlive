class CreatePackagings < ActiveRecord::Migration[5.0]
  def change
    create_table :packagings do |t|
      t.string :uom
      t.float :quantity
      t.string :name
      t.string :description
      t.string :uuid
      t.references :commodity_reference, foreign_key: true

      t.timestamps
    end
  end
end