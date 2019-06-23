class IpAddress < ApplicationRecord
  validates :ip_address, presence: true
end
