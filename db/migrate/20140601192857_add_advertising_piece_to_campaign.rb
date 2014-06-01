class AddAdvertisingPieceToCampaign < ActiveRecord::Migration
  def self.up
    add_attachment :campaigns, :advertising_piece
  end

  def self.down
    remove_attachment :campaigns, :advertising_piece
  end
end