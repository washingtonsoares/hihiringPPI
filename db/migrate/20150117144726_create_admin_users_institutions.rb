class CreateAdminUsersInstitutions < ActiveRecord::Migration
  def change
    create_table :admin_users_institutions do |t|
      t.references :user, index: true
      t.references :institution, index: true

      t.timestamps
    end
  end
end
