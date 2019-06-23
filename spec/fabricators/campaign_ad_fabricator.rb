Fabricator(:campaign_ad) do
  campaign { Fabricate(:campaign) }
  name     { Faker::Hacker.name }
end
