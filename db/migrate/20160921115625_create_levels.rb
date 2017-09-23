class CreateLevels < ActiveRecord::Migration[5.0]
  def change
    create_table :levels do |t|
      t.string :name
      t.integer :position
      t.boolean :needs_moderation, default: true
      t.integer :parent_id
      t.integer :added_by_id
      t.references :classification, foreign_key: true

      t.timestamps
    end
  end
end
