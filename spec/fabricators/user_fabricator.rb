Fabricator(:user) do
  email       { Faker::Internet.safe_email }
  first_name  { Faker::Name.first_name }
  last_name   { Faker::Name.last_name }
  password    { Faker::Internet.password(8, 100) }
  site_admin  true
end
