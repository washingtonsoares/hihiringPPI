class Admin::Comment < ActiveRecord::Base
  belongs_to :publication
  belongs_to :user
end
