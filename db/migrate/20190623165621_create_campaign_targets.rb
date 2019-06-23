class CreateCampaignTargets < ActiveRecord::Migration[6.0]
  def change
    create_table :campaign_targets do |t|
      t.references :campaign, null: false, foreign_key: true
      t.string :landing_page

      t.timestamps
    end
  end
end
