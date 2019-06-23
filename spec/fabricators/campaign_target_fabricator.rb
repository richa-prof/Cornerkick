Fabricator(:campaign_target) do
  campaign     { Fabricate(:campaign) }
  landing_page { Faker::Internet.url }
end
