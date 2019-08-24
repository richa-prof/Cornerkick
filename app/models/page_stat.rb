class PageStat < ApplicationRecord
  belongs_to :page
  belongs_to :campaign
  belongs_to :campaign_source
  belongs_to :campaign_ad
end
