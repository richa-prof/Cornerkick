Fabricator(:contact) do
  transient           groups: []
  first_name          { Faker::Name.first_name }
  last_name           { Faker::Name.last_name }
  email               { Faker::Internet.email }
  phone               { Faker::PhoneNumber.cell_phone }
  account             { Fabricate(:account) }

  after_save do |contact, transients|
    Fabricate.times(2, :browser, contact: contact)
    Fabricate.times(5, :event, contact: contact, browser: contact.browsers.first)
    transients[:groups].sample(2).each do |g|
      Fabricate(:grouping, contact: contact, group: g)
    end
  end
end

Fabricator(:anonymous_contact, from: :contact) do
  first_name nil
  last_name  nil
  email      nil
  phone      nil
end
