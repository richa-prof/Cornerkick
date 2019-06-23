Fabricator(:group) do
  name        { Faker::Hacker.adjective }
  description { Faker::Hacker.phrases }
  account     { Fabricate(:account) }
end
