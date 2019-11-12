class CreateDonations < ActiveRecord::Migration[6.0]
  def change
    create_table :donations do |t|
      t.integer :donor_id
      t.integer :campaign_id
      t.integer :amount

      t.timestamps
    end
    add_index :donations, :donor_id
    add_index :donations, :campaign_id
    add_index :donations, [:donor_id, :campaign_id]
  end
end
