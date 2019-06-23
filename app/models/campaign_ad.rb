class CampaignAd < ApplicationRecord
  belongs_to :campaign, touch: true
  has_one :account, through: :campaign
  has_many :campaign_urls, dependent: :destroy

  validates :name, presence: true
end
