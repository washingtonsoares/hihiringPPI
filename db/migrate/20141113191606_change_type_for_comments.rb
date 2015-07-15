class ChangeTypeForComments < ActiveRecord::Migration
  def change
    change_table :admin_comments do |t|
      t.change :comment, :text
    end  
  end
end
