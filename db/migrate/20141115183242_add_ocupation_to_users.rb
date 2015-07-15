class AddOcupationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ocupation, :string
  end
end
