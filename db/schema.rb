# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_07_14_165256) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "browsers", force: :cascade do |t|
    t.string "fingerprint", null: false
    t.string "user_agent"
    t.string "platform"
    t.bigint "contact_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["contact_id"], name: "index_browsers_on_contact_id"
    t.index ["fingerprint"], name: "index_browsers_on_fingerprint"
  end

  create_table "campaign_ads", force: :cascade do |t|
    t.bigint "campaign_id", null: false
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["campaign_id"], name: "index_campaign_ads_on_campaign_id"
  end

  create_table "campaign_sources", force: :cascade do |t|
    t.bigint "campaign_id", null: false
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["campaign_id"], name: "index_campaign_sources_on_campaign_id"
  end

  create_table "campaign_targets", force: :cascade do |t|
    t.bigint "campaign_id", null: false
    t.string "landing_page"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["campaign_id"], name: "index_campaign_targets_on_campaign_id"
  end

  create_table "campaign_urls", force: :cascade do |t|
    t.bigint "campaign_id", null: false
    t.bigint "campaign_target_id", null: false
    t.bigint "campaign_source_id", null: false
    t.bigint "campaign_ad_id", null: false
    t.bigint "group_id"
    t.string "url", null: false
    t.string "short", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["campaign_ad_id"], name: "index_campaign_urls_on_campaign_ad_id"
    t.index ["campaign_id", "campaign_target_id", "campaign_source_id", "campaign_ad_id"], name: "index_campaign_url_uniqueness", unique: true
    t.index ["campaign_id"], name: "index_campaign_urls_on_campaign_id"
    t.index ["campaign_source_id"], name: "index_campaign_urls_on_campaign_source_id"
    t.index ["campaign_target_id"], name: "index_campaign_urls_on_campaign_target_id"
    t.index ["group_id"], name: "index_campaign_urls_on_group_id"
  end

  create_table "campaigns", force: :cascade do |t|
    t.string "name"
    t.bigint "account_id", null: false
    t.boolean "active"
    t.datetime "started_at"
    t.datetime "ended_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_campaigns_on_account_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone"
    t.bigint "account_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_contacts_on_account_id"
  end

  create_table "detector_conditions", force: :cascade do |t|
    t.bigint "detector_id", null: false
    t.string "type"
    t.jsonb "settings", default: {}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["detector_id"], name: "index_detector_conditions_on_detector_id"
  end

  create_table "detector_effects", force: :cascade do |t|
    t.bigint "detector_id", null: false
    t.string "type"
    t.jsonb "settings", default: {}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["detector_id"], name: "index_detector_effects_on_detector_id"
  end

  create_table "detector_result_notes", force: :cascade do |t|
    t.bigint "detector_result_id", null: false
    t.string "scribe_type", null: false
    t.bigint "scribe_id", null: false
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["detector_result_id"], name: "index_detector_result_notes_on_detector_result_id"
    t.index ["scribe_type", "scribe_id"], name: "index_detector_result_notes_on_scribe_type_and_scribe_id"
  end

  create_table "detector_results", force: :cascade do |t|
    t.bigint "detector_id", null: false
    t.bigint "event_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["detector_id"], name: "index_detector_results_on_detector_id"
    t.index ["event_id"], name: "index_detector_results_on_event_id"
  end

  create_table "detectors", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "name", null: false
    t.text "description"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_detectors_on_account_id"
  end

  create_table "domains", force: :cascade do |t|
    t.string "name"
    t.bigint "account_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_domains_on_account_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "url"
    t.string "referrer"
    t.string "title"
    t.string "remote_host"
    t.string "ga"
    t.string "campaign_name"
    t.string "campaign_source"
    t.string "campaign_medium"
    t.string "campaign_term"
    t.string "campaign_content"
    t.string "event_type"
    t.string "node"
    t.string "node_class"
    t.string "node_href"
    t.jsonb "node_properties", default: {}
    t.bigint "contact_id", null: false
    t.bigint "browser_id", null: false
    t.bigint "ip_address_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["browser_id"], name: "index_events_on_browser_id"
    t.index ["contact_id"], name: "index_events_on_contact_id"
    t.index ["ip_address_id"], name: "index_events_on_ip_address_id"
  end

  create_table "groupings", force: :cascade do |t|
    t.bigint "group_id", null: false
    t.bigint "contact_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["contact_id"], name: "index_groupings_on_contact_id"
    t.index ["group_id"], name: "index_groupings_on_group_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.bigint "account_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_groups_on_account_id"
  end

  create_table "ip_addresses", force: :cascade do |t|
    t.string "ip_address", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ip_address"], name: "index_ip_addresses_on_ip_address"
  end

  create_table "page_stats", force: :cascade do |t|
    t.bigint "page_id", null: false
    t.date "stat_date"
    t.bigint "campaign_id"
    t.bigint "campaign_source_id"
    t.bigint "campaign_ad_id"
    t.integer "visitor_count"
    t.integer "new_visitor_count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["campaign_ad_id"], name: "index_page_stats_on_campaign_ad_id"
    t.index ["campaign_id"], name: "index_page_stats_on_campaign_id"
    t.index ["campaign_source_id"], name: "index_page_stats_on_campaign_source_id"
    t.index ["page_id"], name: "index_page_stats_on_page_id"
  end

  create_table "pages", force: :cascade do |t|
    t.string "path"
    t.string "title"
    t.bigint "domain_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["domain_id"], name: "index_pages_on_domain_id"
  end

  create_table "role_assignments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "role_id", null: false
    t.bigint "account_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_role_assignments_on_account_id"
    t.index ["role_id"], name: "index_role_assignments_on_role_id"
    t.index ["user_id", "role_id", "account_id"], name: "index_role_assignments_on_user_id_and_role_id_and_account_id", unique: true
    t.index ["user_id"], name: "index_role_assignments_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "shops", force: :cascade do |t|
    t.string "shopify_domain", null: false
    t.string "shopify_token", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["shopify_domain"], name: "index_shops_on_shopify_domain", unique: true
  end

  create_table "team_memberships", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "team_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["team_id"], name: "index_team_memberships_on_team_id"
    t.index ["user_id"], name: "index_team_memberships_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.bigint "account_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_teams_on_account_id"
  end

  create_table "trackers", force: :cascade do |t|
    t.string "identifier"
    t.bigint "account_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_trackers_on_account_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "encrypted_password", default: "", null: false
    t.boolean "site_admin", default: false, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "browsers", "contacts"
  add_foreign_key "campaign_ads", "campaigns"
  add_foreign_key "campaign_sources", "campaigns"
  add_foreign_key "campaign_targets", "campaigns"
  add_foreign_key "campaign_urls", "campaign_ads"
  add_foreign_key "campaign_urls", "campaign_sources"
  add_foreign_key "campaign_urls", "campaign_targets"
  add_foreign_key "campaign_urls", "campaigns"
  add_foreign_key "campaign_urls", "groups"
  add_foreign_key "campaigns", "accounts"
  add_foreign_key "contacts", "accounts"
  add_foreign_key "detector_conditions", "detectors"
  add_foreign_key "detector_effects", "detectors"
  add_foreign_key "detector_result_notes", "detector_results"
  add_foreign_key "detector_results", "detectors"
  add_foreign_key "detector_results", "events"
  add_foreign_key "detectors", "accounts"
  add_foreign_key "domains", "accounts"
  add_foreign_key "events", "browsers"
  add_foreign_key "events", "contacts"
  add_foreign_key "events", "ip_addresses"
  add_foreign_key "groupings", "contacts"
  add_foreign_key "groupings", "groups"
  add_foreign_key "groups", "accounts"
  add_foreign_key "page_stats", "campaign_ads"
  add_foreign_key "page_stats", "campaign_sources"
  add_foreign_key "page_stats", "campaigns"
  add_foreign_key "page_stats", "pages"
  add_foreign_key "pages", "domains"
  add_foreign_key "role_assignments", "accounts"
  add_foreign_key "role_assignments", "roles"
  add_foreign_key "role_assignments", "users"
  add_foreign_key "team_memberships", "teams"
  add_foreign_key "team_memberships", "users"
  add_foreign_key "teams", "accounts"
  add_foreign_key "trackers", "accounts"
end
