class CreateAdminFriends < ActiveRecord::Migration
  def change
    create_table :admin_friends do |t|
      t.string :teste

      t.timestamps
    end
  end
end
