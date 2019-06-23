class CreateGroupings < ActiveRecord::Migration[6.0]
  def change
    create_table :groupings do |t|
      t.references :group, null: false, foreign_key: true
      t.references :contact, null: false, foreign_key: true

      t.timestamps
    end
  end
end
