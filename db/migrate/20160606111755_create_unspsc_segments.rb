class CreateUnspscSegments < ActiveRecord::Migration[5.0]
  def change
    create_table :unspsc_segments do |t|
      t.string :code
      t.string :long_code
      t.string :description

      t.timestamps
    end
  end
end
