Fabricator(:campaign_source) do
  campaign { Fabricate(:campaign) }
  name     { Faker::Hacker.name }
end
