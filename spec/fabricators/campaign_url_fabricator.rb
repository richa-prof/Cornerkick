Fabricator(:campaign_url) do
  campaign        { Fabricate(:campaign) }
  campaign_target { |attrs| Fabricate(:campaign_target, campaign: attrs[:campaign]) }
  campaign_source { |attrs| Fabricate(:campaign_source, campaign: attrs[:campaign]) }
  campaign_ad     { |attrs| Fabricate(:campaign_ad, campaign: attrs[:campaign]) }
  url             { Faker::Internet.url }
  short           'tbd'
  group           nil
  before_save do |campaign_url, _transients|
    campaign_url.generate_url
  end
end

