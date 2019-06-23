Fabricator(:campaign) do
  name        { Faker::Hacker.adjective }
  account     { Fabricate(:account) }
  active      false
  started_at  Time.now.utc.yesterday
  ended_at    Time.now.utc.tomorrow
end
