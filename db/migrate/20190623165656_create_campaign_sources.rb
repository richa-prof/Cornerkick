class CreateCampaignSources < ActiveRecord::Migration[6.0]
  def change
    create_table :campaign_sources do |t|
      t.references :campaign, null: false, foreign_key: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
