class CreateHscodeChapters < ActiveRecord::Migration[5.0]
  def change
    create_table :hscode_chapters do |t|
      t.string :category
      t.string :description
      t.references :hscode_section, foreign_key: true

      t.timestamps
    end
    add_index :hscode_chapters, :category, unique: true
  end
end
