class CreateIpAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :ip_addresses do |t|
      t.string :ip_address, null: false, unique: true, index: true

      t.timestamps
    end
  end
end
