require 'securerandom'

Fabricator(:browser) do
  fingerprint                   { SecureRandom.uuid }
  user_agent                    'Chrome'
  platform                      { Faker::Hacker.noun }
  contact(inverse_of: :browsers)
end
