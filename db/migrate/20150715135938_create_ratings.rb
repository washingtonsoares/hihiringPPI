class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.references :users, index: true
      t.references :admin_publications, index: true
      t.integer :nota

      t.timestamps
    end
  end
end
