class CreateBrowsers < ActiveRecord::Migration[6.0]
  def change
    create_table :browsers do |t|
      t.string :fingerprint, null: false, unique: true, index: true
      t.string :user_agent
      t.string :platform
      t.references :contact, null: false, foreign_key: true

      t.timestamps
    end
  end
end
