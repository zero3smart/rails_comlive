class CreateMemberships < ActiveRecord::Migration[5.0]
  def change
    create_table :memberships do |t|
      t.references :user, foreign_key: true
      t.boolean :owner, default: false
      t.references :member, :polymorphic => true

      t.timestamps
    end
  end
end