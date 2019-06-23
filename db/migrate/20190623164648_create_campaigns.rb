class CreateCampaigns < ActiveRecord::Migration[6.0]
  def change
    create_table :campaigns do |t|
      t.string :name
      t.references :account, null: false, foreign_key: true
      t.boolean :active
      t.timestamp :started_at
      t.timestamp :ended_at

      t.timestamps
    end
  end
end
