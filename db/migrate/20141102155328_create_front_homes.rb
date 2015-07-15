class CreateFrontHomes < ActiveRecord::Migration
  def change
    create_table :front_homes do |t|

      t.timestamps
    end
  end
end
