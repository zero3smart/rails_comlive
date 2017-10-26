class CreateApps < ActiveRecord::Migration[5.0]
  def change
    create_table :apps do |t|
      t.string :name
      t.text :description
      t.string :uuid
      t.boolean :default, default: false
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :apps, :uuid, unique: true
  end
end