class CreateClassifications < ActiveRecord::Migration[5.0]
  def change
    create_table :classifications do |t|
      t.string :name
      t.text :description
      t.integer :visibility, default: 0
      t.integer :moderator_id
      t.references :app, foreign_key: true

      t.timestamps
    end
  end
end
