class CreateAdminPublications < ActiveRecord::Migration
  def change
    create_table :admin_publications do |t|
      t.string :title
      t.text :resume
      t.references :user, index: true

      t.timestamps
    end
  end
end
