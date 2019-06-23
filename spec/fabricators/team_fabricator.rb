Fabricator(:team) do
  name    { Faker::Hacker.noun }
  account { Fabricate(:account) }
end
