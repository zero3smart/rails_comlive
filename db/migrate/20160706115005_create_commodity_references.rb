class CreateCommodityReferences < ActiveRecord::Migration[5.0]
  def change
    create_table :commodity_references do |t|
      t.string :name
      t.string :short_description
      t.text :long_description
      t.string :measured_in
      t.boolean :generic, default: false
      t.boolean :moderated, default: false
      t.string :uuid
      t.references :brand, foreign_key: true
      t.references :app, foreign_key: true
      t.references :commodity, foreign_key: true
      t.references :hscode_section, foreign_key: true
      t.references :hscode_chapter, foreign_key: true
      t.references :hscode_heading, foreign_key: true
      t.references :hscode_subheading, foreign_key: true
      t.references :unspsc_segment, foreign_key: true
      t.references :unspsc_family, foreign_key: true
      t.references :unspsc_class, foreign_key: true
      t.references :unspsc_commodity, foreign_key: true

      t.timestamps
    end
  end
end