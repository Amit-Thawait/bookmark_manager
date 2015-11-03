class AuthenticationsController < ApplicationController

  def create
    # render :plain => request.env["omniauth.auth"].inspect
    auth = request.env['omniauth.auth']
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
    if session_destroyed
      flash[:notice] = "You have been logged out."
      redirect_to root_url
    else
      flash[:notice] = "There was problem in logging you out. Please refersh the page to check if you are still signed-in \
        and then try again"
    end
  end

end