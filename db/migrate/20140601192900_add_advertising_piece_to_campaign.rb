class AddAdvertisingPieceToCampaign < ActiveRecord::Migration
  def self.up
    add_column :campaigns, :advertising_piece_file_name, :string, :after => :advertiser_id
    add_column :campaigns, :advertising_piece_content_type, :string, :after => :advertising_piece_file_name
    add_column :campaigns, :advertising_piece_file_size, :integer, :after => :advertising_piece_content_type
    add_column :campaigns, :advertising_piece_updated_at, :datetime, :after => :advertising_piece_file_size
  end

  def self.down
    remove_column :campaigns, :advertising_piece_file_name
    remove_column :campaigns, :advertising_piece_content_type
    remove_column :campaigns, :advertising_piece_file_size
    remove_column :campaigns, :advertising_piece_updated_at
  end
end