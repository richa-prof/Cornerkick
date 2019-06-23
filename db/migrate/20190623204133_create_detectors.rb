class CreateDetectors < ActiveRecord::Migration[6.0]
  def change
    create_table :detectors do |t|
      t.references :account, null: false, foreign_key: true
      t.string :name, null: false
      t.text :description
      t.boolean :active

      t.timestamps
    end
  end
end
