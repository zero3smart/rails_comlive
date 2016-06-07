class CreateUnspscCommodities < ActiveRecord::Migration[5.0]
  def change
    create_table :unspsc_commodities do |t|
      t.string :code
      t.string :long_code
      t.string :description
      t.references :unspsc_class, foreign_key: true

      t.timestamps
    end
  end
end
