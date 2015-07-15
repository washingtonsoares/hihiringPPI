class AddThumbToAdminPublications < ActiveRecord::Migration
  def change
    add_column :admin_publications, :thumb, :string
  end
end
