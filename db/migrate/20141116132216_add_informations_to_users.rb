class AddInformationsToUsers < ActiveRecord::Migration
  def change
      add_column :users, :idade, :integer
      add_column :users, :faculdade, :string
      add_column :users, :curso, :string
  end
end
