class CreateRecurrencePeriods < ActiveRecord::Migration
  def change
    create_table :recurrence_periods do |t|
      t.string :name, limit: 15, null: false
      t.string :description, limit: 20, null: true

      t.timestamps
    end
  end
end
