class Admin::UsersController < Admin::AdminController

  def show
    @user = User.find(params[:id])
    @admin_publications = Admin::Publication.where(user_id: params[:id])
    @usuario = current_user
    respond_to do |format|
      format.html
    end
  end

  def my_publications
    @user = current_user
    @my_publications = current_user.admin_publications
  end

  def indicate
    @indicator = User.find(params[:of])
    @indicate_to = User.find(params[:to])
    UserMailer.indicate_student(@indicator, @indicate_to, params[:dadosindicate]).deliver
  end


  def associa_user_faculdade
    @user = User.find(params[:user_id])
    institutions = params[:datafacu]
    institutions[:faculdades_id].each do |i|
      i = i.to_i
      Admin::UsersInstitutions.create(user_id: @user.id,institution_id: i)
    end
  end

  def associa_user_one_faculdade
    @user = User.find(params[:user_id])
    Admin::UsersInstitutions.create(user_id: @user.id,institution_id: params[:faculdade_id].to_i)
  end



  def eh_novo

    @user = User.find(params[:user])
    @newNotifications = Admin::Friend.where(new: 0, user2: @user,accept: 0,rejected: 0).load
    respond_to do |format|
      format.js
    end

  end


def accept_friend
  @its_friends = Admin::Friend.where(user1: params[:user1],user2: params[:user2]).first
  @its_friends.update(accept: true)
end

def reject_friend
  @it_friends = Admin::Friend.where(user1: params[:user1],user2: params[:user2]).first
  @it_friends.update(rejected: true)
end

def new_friend
  @newFriend   = Admin::Friend.create(user1: User.find(params[:of]), user2: User.find(params[:to]))
  @newFriend.save
  @usuario = User.find(params[:to])
  @enviador = User.find(params[:of])
  @path = admin_user_path(@usuario)

end

  def welcome
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  # PATCH/PUT /users/:id.:format
  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admin_user_path(@user) }
        format.js
      else
        redirect_to admin_user_path(current_user)
      end
    end
  end

  # GET/PATCH /users/:id/finish_signup
  def finish_signup
    # authorize! :update, @user 
    if request.patch? && params[:user] #&& params[:user][:email]
      if @user.update(user_params)
        @user.skip_reconfirmation!
        sign_in(@user, :bypass => true)
        redirect_to @user, notice: 'Your profile was successfully updated.'
      else
        @show_errors = true
      end
    end
  end

  # DELETE /users/:id.:format
  def destroy
    # authorize! :delete, @user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        format.js
      else
        redirect_to admin_user_path(current_user)
      end
    end
  end

  def user_params
    accessible = [:name, :email, :username, :image, :ocupation, :faculdade, :idade, :curso] # extend with your own params
    accessible << [:password, :password_confirmation] unless params[:user][:password].blank?
    params.require(:user).permit(accessible)
  end

end
