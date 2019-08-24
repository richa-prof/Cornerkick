class CreatePageStats < ActiveRecord::Migration[6.0]
  def change
    create_table :page_stats do |t|
      t.references :page, null: false, foreign_key: true
      t.date :stat_date
      t.references :campaign, null: true, foreign_key: true
      t.references :campaign_source, null: true, foreign_key: true
      t.references :campaign_ad, null: true, foreign_key: true
      t.integer :visitor_count
      t.integer :new_visitor_count

      t.timestamps
    end
  end
end
