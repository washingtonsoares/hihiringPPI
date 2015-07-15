class CreateAdminComments < ActiveRecord::Migration
  def change
    create_table :admin_comments do |t|
      t.string :comment
      t.references :publication, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
