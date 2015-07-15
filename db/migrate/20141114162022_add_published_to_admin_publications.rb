class AddPublishedToAdminPublications < ActiveRecord::Migration
  def change
    add_column :admin_comments, :published, :boolean, default: true
  end
end
