class RenameUsersInAdminFriends < ActiveRecord::Migration
  def change
    rename_column :admin_friends, :user_1_id, :user1
    rename_column :admin_friends, :user_2_id, :user2
  end
end
