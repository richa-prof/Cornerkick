class Tracker < ApplicationRecord
  belongs_to :account, touch: true

  validates :identifier, presence: true
end
