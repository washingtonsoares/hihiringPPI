class AddNewToAdminFriends < ActiveRecord::Migration
  def change
    add_column :admin_friends, :new, :boolean, default: false
  end
end
