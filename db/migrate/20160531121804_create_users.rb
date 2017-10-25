class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email, null: false
      t.string :provider, null: false
      t.string :uid, null: false
      t.string :oauth_token

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :oauth_token, unique: true
  end
end