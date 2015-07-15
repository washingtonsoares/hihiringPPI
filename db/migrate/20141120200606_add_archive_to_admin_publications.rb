class AddArchiveToAdminPublications < ActiveRecord::Migration
  def change
    add_column :admin_publications, :archive, :string
  end
end
