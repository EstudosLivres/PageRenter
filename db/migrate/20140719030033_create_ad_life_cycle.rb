class CreateAdLifeCycle < ActiveRecord::Migration
  def change
    # The states of the campaign life cycle
    create_table :ad_states do |t|
      t.string :name, limit: 40, null: false
      t.string :description, limit: 140, null: true

      t.timestamps
    end

    # The history of when the campaign got the states
    create_table :ad_history_states do |t|
      t.belongs_to :ad
      t.belongs_to :ad_state
      t.string :reason, limit: 140, null: true

      t.timestamps
    end
  end
end
