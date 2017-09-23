class CreateLists < ActiveRecord::Migration[5.0]
  def change
    create_table :lists do |t|
      t.string :commodities, array: true, default: []
      t.references :user, foreign_key: true

      t.timestamps
    end

    add_index :lists, :commodities, using: 'gin'
  end
end
