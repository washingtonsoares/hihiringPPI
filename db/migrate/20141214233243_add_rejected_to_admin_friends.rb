class AddRejectedToAdminFriends < ActiveRecord::Migration
  def change
    add_column :admin_friends, :rejected, :boolean, default: false
  end
end
