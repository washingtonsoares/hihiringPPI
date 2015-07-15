module Admin::CommentsHelper

  def retornaNome(id)
    @user = User.find(id)
    if @user
      return @user.name
    end
    return nil
  end

end
