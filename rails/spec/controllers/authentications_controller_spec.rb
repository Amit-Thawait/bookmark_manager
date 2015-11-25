require 'rails_helper'

describe AuthenticationsController do

  before(:each) do
    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      provider:    'github',
      uid:         '12345',
      credentials: {
                     token:   '3db44dc324c6417113674b57c9ef098a5e9bbd8b866',
                     expires: false
      },
      info:        {
                     name:     'Amit Thawait',
                     email:    'test@gmail.com',
                     nickname: 'Amit-Thawait'
      },
      extra:       {
      	             raw_info: {
                       email:       'test@gmail.com',
                       location:    'Pune',
                       gravatar_id: '123456789'
                     }
      }
    })

    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
  end

  describe "#create" do

    it "should successfully create a user" do
      expect {
        post :create, provider: :github
      }.to change{ User.count }.by(1)
    end

    it "should successfully create a session" do
      expect(session[:user_id]).to be_nil
      post :create, provider: :github
      expect(session[:user_id]).not_to be_nil
    end

    it "should redirect the user to the root url" do
      post :create, provider: :github
      expect(response).to redirect_to bookmarks_url
    end

  end

  describe "#destroy" do
    before do
      post :create, provider: :github
    end

    it "should clear the session" do
      expect(session[:user_id]).not_to be_nil
      delete :destroy
      expect(session[:user_id]).to be_nil
    end

    it "should redirect to the home page" do
      delete :destroy
      expect(response).to redirect_to root_url
    end
  end

end