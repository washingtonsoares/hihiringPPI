class CreateAdminInstitutions < ActiveRecord::Migration
  def change
    create_table :admin_institutions do |t|
      t.string :name

      t.timestamps
    end
  end
end
