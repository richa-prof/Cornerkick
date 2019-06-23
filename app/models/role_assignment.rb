class RoleAssignment < ApplicationRecord
  belongs_to :user
  belongs_to :role
  belongs_to :account

  validates :role, uniqueness: { scope: %i[user account] }
  validates :role, presence: true
  validates :user, presence: true
end
