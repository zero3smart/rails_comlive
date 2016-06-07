class CreateHscodeSubheadings < ActiveRecord::Migration[5.0]
  def change
    create_table :hscode_subheadings do |t|
      t.string :category
      t.string :description
      t.references :hscode_heading, foreign_key: true

      t.timestamps
    end
    add_index :hscode_subheadings, :category, unique: true
  end
end
