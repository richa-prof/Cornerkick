class CreateDetectorResultNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :detector_result_notes do |t|
      t.references :detector_result, null: false, foreign_key: true
      t.references :scribe, polymorphic: true, null: false
      t.text :content

      t.timestamps
    end
  end
end
