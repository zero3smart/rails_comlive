class CreateInvitations < ActiveRecord::Migration[5.0]
  def change
    create_table :invitations do |t|
      t.integer :sender_id
      t.string :recipient_email
      t.string :token
      t.boolean :accepted, default: false
      t.references :app, foreign_key: true

      t.timestamps
    end
    add_index :invitations, :token, unique: true
  end
end