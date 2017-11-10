class CreateBrands < ActiveRecord::Migration[5.0]
  def change
    create_table :brands do |t|
      t.string :name
      t.boolean :official, default: false
      t.string :logo
      t.string :description
      t.string :uuid

      t.timestamps
    end
    add_index :brands, :uuid, unique: true
  end
end