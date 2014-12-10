class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      # Value paid by the Adv per: click on the link
      t.integer :per_visitation, null: false
      # Value paid by the Adv per: share, re-tweet... interactions that expose his brand
      t.integer :per_foreign_interaction, null: false
      # Value paid by the Adv per: like, comment, tweet... interactions on the same local as the post
      t.integer :per_local_interaction, null: false
      # Value paid by the Adv per: new costumer (something bought, assignation...)
      t.integer :per_conversion, null: false
      # Value paid by the Adv per: per views (appearances)
      t.integer :per_impression, null: true
      # Flag, saying if it bid is the current (default: true for it last)
      t.boolean :active, null: false
      # The date it was closed because a new Bid config started
      t.datetime :closed_date, null: true

      # Relationships
      t.belongs_to :ad, index: true, null: false
      t.belongs_to :currency, index: true, null: false

      t.timestamps
    end
  end
end
