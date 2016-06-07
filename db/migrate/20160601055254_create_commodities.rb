class CreateCommodities < ActiveRecord::Migration[5.0]
  def change
    create_table :commodities do |t|
      t.string :short_description
      t.text :long_description
      t.boolean :generic, default: false
      t.references :app, foreign_key: true

      t.timestamps
    end
  end
end
