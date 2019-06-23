class CreateRoleAssignments < ActiveRecord::Migration[6.0]
  def change
    create_table :role_assignments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :role, null: false, foreign_key: true
      t.references :account, null: false, foreign_key: true

      t.timestamps

      t.index %i[user_id role_id account_id], unique: true
    end
  end
end
