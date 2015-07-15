class AddRelationschipsToAdminFriends < ActiveRecord::Migration
  def change
    add_column :admin_friends, :user_1_id, :integer,index: true
    add_column :admin_friends, :user_2_id, :integer,index: true
  end
end
