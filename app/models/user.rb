class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,  :validatable

  validates :email, presence: true

  has_many :team_memberships
  has_many :teams, through: :team_memberships

  has_many :role_assignments
  has_many :roles, through: :role_assignments

  def account_admin?(account)
    role = Role.find_by(name: Role::ACCOUNT_ADMIN)
    RoleAssignment.where(user: self, role: role, account: account).exists?
  end
end
