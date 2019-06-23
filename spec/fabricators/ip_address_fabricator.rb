Fabricator(:ip_address) do
  ip_address { Faker::Internet.ip_v6_address }
end
