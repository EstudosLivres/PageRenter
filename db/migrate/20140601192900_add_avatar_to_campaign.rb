class AddAvatarToCampaign < ActiveRecord::Migration
  def self.up
    add_column :campaigns, :avatar_file_name, :string, :after => :advertiser_id
    add_column :campaigns, :avatar_content_type, :string, :after => :avatar_file_name
    add_column :campaigns, :avatar_file_size, :integer, :after => :avatar_content_type
    add_column :campaigns, :avatar_updated_at, :datetime, :after => :avatar_file_size
  end

  def self.down
    remove_column :campaigns, :avatar_file_name
    remove_column :campaigns, :avatar_content_type
    remove_column :campaigns, :avatar_file_size
    remove_column :campaigns, :avatar_updated_at
  end
end