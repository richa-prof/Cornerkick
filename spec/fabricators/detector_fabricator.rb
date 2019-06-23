Fabricator(:detector) do
  account             { Fabricate(:account) }
  name                { Faker::Name.name }
  description         { Faker::Movies::StarWars.quote }
  active              false
end
