class AddAuthorToAdminPublications < ActiveRecord::Migration
  def change
    add_column :admin_publications, :author, :string
  end
end
