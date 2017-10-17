class CreateStandards < ActiveRecord::Migration[5.0]
  def change
    create_table :standards do |t|
      t.string :name
      t.text :description
      t.string :logo
      t.boolean :official, default: false

      t.timestamps
    end
  end
end