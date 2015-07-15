class AddAcronymToAdminInstitutions < ActiveRecord::Migration
  def change
    add_column :admin_institutions, :acronym, :string
  end
end
