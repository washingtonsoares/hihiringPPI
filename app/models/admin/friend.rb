class Admin::Friend < ActiveRecord::Base
  belongs_to :user1, class_name: "User", :foreign_key => "user1"
  belongs_to :user2, class_name: "User", :foreign_key => "user2"
end
