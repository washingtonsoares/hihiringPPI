class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #respond_to :html, :xml, :json

  protect_from_forgery with: :exception

  def ensure_signup_complete
    # Ensure we don't go into an infinite loop
    return if action_name == 'finish_signup'

    # Redirect to the 'finish_signup' page if the user
    # email hasn't been verified yet
    if current_user && !current_user.email_verified?
      redirect_to finish_signup_path(current_user)
    end
  end

  def after_sign_in_path_for ( resource )
    if resource.sign_in_count == 1
      return admin_welcome_url(current_user)
    else
      return admin_user_url(current_user)
    end
  end

  def after_sign_out_path_for ( resource_or_scope )
    return new_user_session_url
  end

end
