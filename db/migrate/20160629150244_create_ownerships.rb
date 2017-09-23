class CreateOwnerships < ActiveRecord::Migration[5.0]
  def change
    create_table :ownerships do |t|
      t.references :parent, :polymorphic => true
      t.references :child, :polymorphic => true

      t.timestamps
    end
  end
end
