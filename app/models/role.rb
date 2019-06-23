class Role < ApplicationRecord
  ACCOUNT_ADMIN = 'Account Admin'.freeze
  TEAM_ADMIN    = 'Team Admin'.freeze
  TEAM_MEMBER   = 'Team Member'.freeze

  validates :name, presence: true, uniqueness: true, inclusion: [ACCOUNT_ADMIN, TEAM_ADMIN, TEAM_MEMBER]

  has_many :role_assignments
end
