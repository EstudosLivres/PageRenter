class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :name, limit: 75, null: false
      t.string :launch_date, limit: 10, null: false
      t.string :end_date, limit: 10, null: false
      t.belongs_to :user

      t.timestamps
    end
  end
end
