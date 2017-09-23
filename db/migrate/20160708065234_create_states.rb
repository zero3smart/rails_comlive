class CreateStates < ActiveRecord::Migration[5.0]
  def change
    create_table :states do |t|
      t.string :status
      t.text :info
      t.string :url
      t.integer :visibility, default: 0
      t.references :commodity_reference, foreign_key: true

      t.timestamps
    end
  end
end
