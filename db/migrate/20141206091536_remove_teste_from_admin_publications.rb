class RemoveTesteFromAdminPublications < ActiveRecord::Migration
  def change
    remove_column :admin_friends, :teste
  end
end
