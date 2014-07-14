class AddAvatarToProfile < ActiveRecord::Migration
  def self.up
    add_column :profiles, :avatar_file_name, :string, :after => :user_id
    add_column :profiles, :avatar_content_type, :string, :after => :avatar_file_name
    add_column :profiles, :avatar_file_size, :integer, :after => :avatar_content_type
    add_column :profiles, :avatar_updated_at, :datetime, :after => :avatar_file_size
  end

  def self.down
    remove_column :profiles, :avatar_file_name
    remove_column :profiles, :avatar_content_type
    remove_column :profiles, :avatar_file_size
    remove_column :profiles, :avatar_updated_at
  end
end
