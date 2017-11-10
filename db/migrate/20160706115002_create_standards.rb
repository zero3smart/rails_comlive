class CreateStandards < ActiveRecord::Migration[5.0]
  def change
    create_table :standards do |t|
      t.string :name
      t.text :description
      t.string :logo
      t.string :uuid
      t.boolean :official, default: false

      t.timestamps
    end
    add_index :standards, :uuid, unique: true
  end
end