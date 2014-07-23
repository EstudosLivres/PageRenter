class AddAvatarToAds < ActiveRecord::Migration
  def self.up
    add_column :ads, :avatar_file_name, :string, :after => :advertiser_id
    add_column :ads, :avatar_content_type, :string, :after => :avatar_file_name
    add_column :ads, :avatar_file_size, :integer, :after => :avatar_content_type
    add_column :ads, :avatar_updated_at, :datetime, :after => :avatar_file_size
  end

  def self.down
    remove_column :ads, :avatar_file_name
    remove_column :ads, :avatar_content_type
    remove_column :ads, :avatar_file_size
    remove_column :ads, :avatar_updated_at
  end
end