class Group < ApplicationRecord
  belongs_to :account

  has_many :groupings
  has_many :contacts, through: :groupings

  validates :name, presence: true
end
