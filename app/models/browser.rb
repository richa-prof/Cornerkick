class Browser < ApplicationRecord
  belongs_to :contact
  has_many :events

  validates :fingerprint, presence: true
end
