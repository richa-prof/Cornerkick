class CreateCampaignUrls < ActiveRecord::Migration[6.0]
  def change
    create_table :campaign_urls do |t|
      t.references :campaign, null: false, foreign_key: true
      t.references :campaign_target, null: false, foreign_key: true
      t.references :campaign_source, null: false, foreign_key: true
      t.references :campaign_ad, null: false, foreign_key: true
      t.references :group, null: true, foreign_key: true
      t.string :url, null: false
      t.string :short, null: false

      t.timestamps

      t.index %i[campaign_id campaign_target_id campaign_source_id campaign_ad_id], name: 'index_campaign_url_uniqueness', unique: true
    end
  end
end
