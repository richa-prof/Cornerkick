class Campaign < ApplicationRecord
  belongs_to :account
  has_many :campaign_ads
  has_many :campaign_sources
  has_many :campaign_targets
  has_many :campaign_urls

  validates :name, presence: true

  def generate_campaign_urls
    urls = []
    campaign_targets.each do |t|
      campaign_sources.each do |s|
        campaign_ads.each do |a|
          url = CampaignUrl.find_by campaign: self, campaign_target: t, campaign_source: s, campaign_ad: a
          url = CampaignUrl.new campaign: self, campaign_target: t, campaign_source: s, campaign_ad: a unless url
          url.generate_url
          url.short = 'tbd'
          url.save

          urls << url
        end
      end
    end
    self.campaign_urls = urls
  end

  def self.process_visit(visit)
    uri = URI(visit.url)

    campaign = locate_campaign uri
    return unless campaign

    campaign.campaign_urls.each do |cu|
      cu.process_visit visit
    end
  end

  def self.locate_campaign(uri)
    params = Rack::Utils.parse_nested_query(uri.query)
    campaign_name = params['utm_campaign']

    Campaign.find_by name: campaign_name
  end
end
