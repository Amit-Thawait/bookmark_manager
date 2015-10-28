Rails.application.config.middleware.use OmniAuth::Builder do

  # GITHUB
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']

  # GOOGLE
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET']

  # TWITTER
  provider :twitter, ENV['API_KEY'], ENV['API_SECRET']

  # FACEBOOK
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']

end