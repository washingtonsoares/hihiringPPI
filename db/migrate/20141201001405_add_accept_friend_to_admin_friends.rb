class AddAcceptFriendToAdminFriends < ActiveRecord::Migration
  def change
    add_column :admin_friends, :accept, :boolean, default: false
  end
end
