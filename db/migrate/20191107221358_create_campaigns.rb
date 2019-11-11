class CreateCampaigns < ActiveRecord::Migration[6.0]
  def change
    create_table :campaigns do |t|
      t.text :content
      t.string :duration
      t.string :category
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :campaigns, [:user_id, :created_at]

  end
end
