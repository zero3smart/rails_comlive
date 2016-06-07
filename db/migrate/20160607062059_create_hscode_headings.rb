class CreateHscodeHeadings < ActiveRecord::Migration[5.0]
  def change
    create_table :hscode_headings do |t|
      t.string :category
      t.string :description
      t.references :hscode_chapter, foreign_key: true

      t.timestamps
    end
    add_index :hscode_headings, :category, unique: true
  end
end
