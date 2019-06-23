class CreateDetectorConditions < ActiveRecord::Migration[6.0]
  def change
    create_table :detector_conditions do |t|
      t.references :detector, null: false, foreign_key: true
      t.string :type
      t.jsonb :settings, default: {}

      t.timestamps
    end
  end
end
