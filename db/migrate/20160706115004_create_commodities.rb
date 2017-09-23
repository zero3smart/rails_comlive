class CreateCommodities < ActiveRecord::Migration[5.0]
  def change
    create_table :commodities do |t|
      t.string :name
      t.string :short_description
      t.text :long_description
      t.string :measured_in
      t.boolean :generic, default: true
      t.boolean :moderated, default: false
      t.string :uuid
      t.integer :visibility, default: 0
      t.references :brand, foreign_key: true

      t.timestamps
    end
    add_index :commodities, :uuid, unique: true
  end
end
