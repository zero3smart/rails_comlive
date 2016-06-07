class CreateHscodeSections < ActiveRecord::Migration[5.0]
  def change
    create_table :hscode_sections do |t|
      t.string :category
      t.string :description
      t.text :range, array: true, default: []

      t.timestamps
    end
    add_index :hscode_sections, :category, unique: true
  end
end
