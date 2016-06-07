class CreateUnspscClasses < ActiveRecord::Migration[5.0]
  def change
    create_table :unspsc_classes do |t|
      t.string :code
      t.string :long_code
      t.string :description
      t.references :unspsc_family, foreign_key: true

      t.timestamps
    end
  end
end
