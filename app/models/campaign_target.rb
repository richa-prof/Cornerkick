class CampaignTarget < ApplicationRecord
  belongs_to :campaign, touch: true
  has_one :account, through: :campaign
  has_many :campaign_urls, dependent: :destroy

  validates :landing_page, presence: true
end
