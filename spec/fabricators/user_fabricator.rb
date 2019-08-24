Fabricator(:user) do
  email       { Faker::Internet.safe_email }
  first_name  { Faker::Name.first_name }
  last_name   { Faker::Name.last_name }
  password    { Faker::Internet.password(min_length: 8, max_length: 100) }
  site_admin  true
end
