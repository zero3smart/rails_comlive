class CreateClassificationStandards < ActiveRecord::Migration[5.0]
  def change
    create_table :classification_standards do |t|
      t.boolean :inheritable, default: false
      t.boolean :force, default: false
      t.boolean :needs_moderation, default: true
      t.integer :added_by_id
      t.references :level, foreign_key: true
      t.references :standard, foreign_key: true

      t.timestamps
    end
  end
end
