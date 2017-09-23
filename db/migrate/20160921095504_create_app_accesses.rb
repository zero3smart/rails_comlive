class CreateAppAccesses < ActiveRecord::Migration[5.0]
  def change
    create_table :app_accesses do |t|
      t.boolean :owner, default: false
      t.boolean :contributor, default: false
      t.integer :added_by_id
      t.references :app, foreign_key: true
      t.references :classification, foreign_key: true

      t.timestamps
    end
  end
end
