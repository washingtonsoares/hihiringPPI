class AddVideoToAdminPublications < ActiveRecord::Migration
  def change
    add_column :admin_publications, :video, :string
  end
end
