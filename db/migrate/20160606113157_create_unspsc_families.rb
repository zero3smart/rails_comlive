class CreateUnspscFamilies < ActiveRecord::Migration[5.0]
  def change
    create_table :unspsc_families do |t|
      t.string :code
      t.string :long_code
      t.string :description
      t.references :unspsc_segment, foreign_key: true

      t.timestamps
    end
  end
end
