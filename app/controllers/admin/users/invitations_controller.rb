class Admin::Users::InvitationsController < Devise::InvitationsController

  prepend_before_filter :authenticate_inviter!, :only => [:new, :create]
  prepend_before_filter :has_invitations_left?, :only => [:create]
  prepend_before_filter :require_no_authentication, :only => [:edit, :update, :destroy]
  prepend_before_filter :resource_from_invitation_token, :only => [:edit, :destroy]
  helper_method :after_sign_in_path_for

  # GET /resource/invitation/new
  def new
    self.resource = resource_class.new
    @users = User.all
    render :new

    /
    respond_to do |format|
      format.js
    end
    /

  end

  # POST /resource/invitation
  def create
    resource = invite_resource
    if resource.errors.empty?
      yield resource if block_given?
      set_flash_message :notice, :send_instructions, :email => resource.email if resource.invitation_sent_at
      #respond_with resource, :location => after_invite_path_for(admin_users_index_path)
      redirect_to(admin_users_index_path)
      logger.debug "Salvou"
    else
      # respond_with_navigational(resource) { render admin_users_index_path(resource_name) }
      # respond_with resource
      redirect_to(admin_users_index_path)
      flash[:error] = "this email can't be saved"
      logger.debug "Nao salvou"
    end
  end

  # GET /resource/invitation/accept?invitation_token=abcdef
  def edit
    resource.invitation_token = params[:invitation_token]
    render :edit
  end

  # PUT /resource/invitation
  def update
    self.resource = accept_resource

    if resource.errors.empty?
      yield resource if block_given?
      flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
      set_flash_message :notice, flash_message
      sign_in(resource_name, resource)
      respond_with resource, :location => after_accept_path_for(resource)
    else
      respond_with_navigational(resource) { render :edit }
    end
  end

  # GET /resource/invitation/remove?invitation_token=abcdef
  def destroy
    resource.destroy
    set_flash_message :notice, :invitation_removed
    redirect_to after_sign_out_path_for(resource_name)
  end

  protected

  # this is called when creating invitation
  # should return an instance of resource class
  /
  def invite_resource
    # skip sending emails on invite
    resource_class.invite!(invite_params, current_inviter) do |u|
      u.skip_invitation = false
    end
  end
  /

  # this is called when accepting invitation
  # should return an instance of resource class
  def accept_resource
    resource = resource_class.accept_invitation!(update_resource_params)
    # Report accepting invitation to analytics
    # Analytics.report(invite.accept, resource.id)
    resource
  end

  def current_inviter
    @current_inviter ||= authenticate_inviter!
  end

  def has_invitations_left?
    unless current_inviter.nil? || current_inviter.has_invitations_left?
      self.resource = resource_class.new
      set_flash_message :alert, :no_invitations_remaining
      respond_with_navigational(resource) { render :new }
    end
  end

  def resource_from_invitation_token
    unless params[:invitation_token] && self.resource = resource_class.find_by_invitation_token(params[:invitation_token], true)
      set_flash_message(:alert, :invitation_token_invalid)
      redirect_to after_sign_out_path_for(resource_name)
    end
  end

  def invite_params
    devise_parameter_sanitizer.sanitize(:invite)
  end

  def update_resource_params
    devise_parameter_sanitizer.sanitize(:accept_invitation)
  end

end