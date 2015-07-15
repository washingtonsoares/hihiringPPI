class Admin::FriendsController < Admin::AdminController

  def friendship
    # @friendship = Admin::Friend.where(user1: :params[user1],user2 from admin_friends where user2=1 or user1=1)
    @friendship = Admin::Friend.find_by_sql('select * from admin_friends where user1=1 or user2=1')
  end

end
