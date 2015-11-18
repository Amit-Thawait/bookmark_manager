class AuthenticationsController < ApplicationController

  def create
    # render :plain => request.env["omniauth.auth"].inspect
    auth = request.env['omniauth.auth']
    session[:provider] = auth['provider']
    session[:access_token] = auth['credentials']['token']
    if session[:user_id].blank?
      @user = User.find_or_create_by(email: auth.extra.raw_info.email)
      self.current_user = @user
    end
    @identity = Identity.find_or_create_by(provider: auth['provider'], uid: auth['uid'], user_id: current_user.id)

    if signed_in? && @identity.user == current_user
      redirect_to bookmarks_url, notice: "Signed in successfully."
    else
      redirect_to root_url, notice: "You could not be authenticated. Please Try again"
    end
  end

  def destroy
    session_destroyed = session.delete(:user_id).present?
    after_destroy(session_destroyed)
    redirect_to root_url if session_destroyed
  end

  def destroy_provider_session
    session_destroyed = session.delete(:user_id).present?
    after_destroy(session_destroyed)
    redirect_to "https://www.github.com/logout?access_token=#{session[:access_token]}&redirect_url=#{root_url}"
  end

  private def after_destroy(secrets_destroyed)
    if secrets_destroyed
      flash[:notice] = "You have been logged out."
    else
      flash[:notice] = "There was problem in logging you out. Please refersh the page to check if you are still signed-in \
        and then try again"
    end
  end

end