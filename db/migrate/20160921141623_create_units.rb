class CreateUnits < ActiveRecord::Migration[5.0]
  def change
    create_table :units do |t|
      t.string :uom
      t.string :value_type
      t.float :min
      t.float :max
      t.boolean :force
      t.boolean :needs_moderation, default: true
      t.boolean :inheritable, default: false
      t.integer :added_by_id
      t.references :level, foreign_key: true

      t.timestamps
    end
  end
end
