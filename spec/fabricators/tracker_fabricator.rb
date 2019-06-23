Fabricator(:tracker) do
  identifier { Faker::Hacker.noun }
  account    { Fabricate(:account) }
end
