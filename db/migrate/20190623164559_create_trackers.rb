class CreateTrackers < ActiveRecord::Migration[6.0]
  def change
    create_table :trackers do |t|
      t.string :identifier
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
