class Ratings < ActiveRecord::Base
  belongs_to :users
  belongs_to :admin_publications
end
