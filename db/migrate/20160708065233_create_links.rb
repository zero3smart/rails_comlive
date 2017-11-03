class CreateLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :links do |t|
      t.string :url
      t.text :description
      t.integer :visibility, default: 0
      t.references :app, foreign_key: true
      t.references :commodity_reference, foreign_key: true

      t.timestamps
    end
  end
end