class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :url
      t.string :referrer
      t.string :title
      t.string :remote_host

      t.string :ga

      t.string :campaign_name
      t.string :campaign_source
      t.string :campaign_medium
      t.string :campaign_term
      t.string :campaign_content

      t.string :event_type
      t.string :node
      t.string :node_class
      t.string :node_href

      t.jsonb :node_properties, default: {}

      t.references :contact, null: false, foreign_key: true
      t.references :browser, null: false, foreign_key: true
      t.references :ip_address, null: false, foreign_key: true

      t.timestamps
    end
  end
end
