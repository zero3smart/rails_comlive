class CreateStandards < ActiveRecord::Migration[5.0]
  def change
    create_table :standards do |t|
      t.string :name
      t.string :code
      t.string :version
      t.text :description
      t.string :logo
      t.string :certifier
      t.string :certifier_url
      t.string :uuid
      t.boolean :official, default: false
      t.integer :visibility, default: 0
      t.references :brand, foreign_key: true

      t.timestamps
    end
    add_index :standards, :uuid, unique: true
  end
end
