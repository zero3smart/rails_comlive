class CreateStandardizations < ActiveRecord::Migration[5.0]
  def change
    create_table :standardizations do |t|
      t.references :user, foreign_key: true
      t.references :standard, foreign_key: true
      t.references :referable, :polymorphic => true

      t.timestamps
    end
  end
end
