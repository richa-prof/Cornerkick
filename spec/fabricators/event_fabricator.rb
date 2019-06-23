Fabricator(:event) do
  url                           { Faker::Internet.url }
  referrer                      { Faker::Internet.url }
  title                         { Faker::Movies::StarWars.quote }
  remote_host                   { Faker::Internet.ip_v6_address }
  event_type                    { %w[visit click].sample }
  campaign_name                 'MyString'
  campaign_source               'MyString'
  campaign_medium               'MyString'
  campaign_term                 'MyString'
  campaign_content              'MyString'

  contact(inverse_of: :contact) { Fabricate(:contact) }
  browser                       { |attrs, _| Fabricate(:browser, contact: attrs[:contact]) }
  ip_address                    { Fabricate(:ip_address) }
end
