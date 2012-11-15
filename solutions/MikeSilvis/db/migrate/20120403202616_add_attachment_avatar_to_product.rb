class AddAttachmentAvatarToProduct < ActiveRecord::Migration
  def change
    add_column :products, :avatar_file_name, :string
    add_column :products, :avatar_content_type, :string
    add_column :products, :avatar_file_size, :integer
    add_column :products, :avatar_updated_at, :datetime
  end
end
