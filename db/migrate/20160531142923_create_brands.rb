class CreateBrands < ActiveRecord::Migration[5.0]
  def change
    create_table :brands do |t|
      t.string :name
      t.boolean :official, default: false
      t.string :logo
      t.string :description
      t.string :phone
      t.string :location
      t.string :email
      t.string :url
      t.string :skype_username
      t.string :facebook_address
      t.string :twitter_handle
      t.string :open_corporate_url
      t.string :wipo_url
      t.string :logo
      t.string :uuid

      t.timestamps
    end
    add_index :brands, :uuid, unique: true
  end
end
