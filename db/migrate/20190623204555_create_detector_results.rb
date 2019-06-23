class CreateDetectorResults < ActiveRecord::Migration[6.0]
  def change
    create_table :detector_results do |t|
      t.references :detector, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
