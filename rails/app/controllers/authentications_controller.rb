class AuthenticationsController < ApplicationController

  def create
    # render :plain => request.env["omniauth.auth"].inspect
    auth = request.env["omniauth.auth"]
    session[:access_token] = auth["credentials"]["token"]
    session[:provider_userid] = auth['uid']
    @authentication = Authentication.find_or_create_by(provider: auth['provider'], uid: auth['uid'])
    if @authentication
      flash[:notice] = "Signed in successfully."
    else
      raise "User could not be authenticated. Please Try again"
    end
    redirect_to bookmarks_url
  end

  def destroy
    authentication = Authentication.find(params[:id])
    authentication.destroy if @authentication
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end

end