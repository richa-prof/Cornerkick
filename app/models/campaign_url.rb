class CampaignUrl < ApplicationRecord
  belongs_to :campaign, touch: true
  belongs_to :campaign_target
  belongs_to :campaign_source
  belongs_to :campaign_ad
  belongs_to :group, optional: true

  has_one :account, through: :campaign

  def generate_url
    uri = URI(campaign_target.landing_page)
    query = { utm_campaign: campaign.name, utm_source: campaign_source.name, utm_content: campaign_ad.name }
    uri.query = query.to_query
    self.url = uri.to_s
  end

  def process_visit(visit)
    uri = URI(visit.url)
    target_uri = URI(campaign_target.landing_page)
    params = Rack::Utils.parse_nested_query(uri.query)
    camp_name = params['utm_campaign']
    source = params['utm_source']
    ad = params['utm_content']

    return unless target_uri.host.eql?(uri.host) && target_uri.path.eql?(uri.path)
    return unless campaign.name.eql? camp_name
    return unless campaign_source.name.eql? source
    return unless campaign_ad.name.eql? ad

    visit.contact.add_group group unless group.nil?
  end
end
