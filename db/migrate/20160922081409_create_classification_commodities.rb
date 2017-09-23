class CreateClassificationCommodities < ActiveRecord::Migration[5.0]
  def change
    create_table :classification_commodities do |t|
      t.boolean :needs_moderation
      t.references :level, foreign_key: true
      t.references :commodity, foreign_key: true
      t.integer :added_by_id

      t.timestamps
    end
  end
end
