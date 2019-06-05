class Account < ApplicationRecord
  validates :name, presence: true

  # has_many :campaigns
  # has_many :contacts
  # has_many :groups
  #
  # has_many :role_assignments
  # has_many :users, through: :role_assignments
  # has_many :roles, through: :role_assignments
  #
  # has_many :teams
  #
  # has_many :progressions
  #
  # has_many :trackers
  #
  # has_many :detectors
end
