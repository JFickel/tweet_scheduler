# Set up gems listed in the Gemfile.
# See: http://gembundler.com/bundler_setup.html
#      http://stackoverflow.com/questions/7243486/why-do-you-need-require-bundler-setup
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

# Require gems we care about
require 'rubygems'

require 'uri'
require 'pathname'

require 'pg'
require 'active_record'
require 'logger'

require 'twitter'
require 'debugger'
require 'omniauth'
require 'omniauth-twitter'


require 'sinatra'
require "sinatra/reloader" if development?
require 'twitter'
require 'erb'

# Some helper constants for path-centric logic
APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

APP_NAME = APP_ROOT.basename.to_s

# Set up the controllers and helpers
Dir[APP_ROOT.join('app', 'controllers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'helpers', '*.rb')].each { |file| require file }

# Set up the database and models
require APP_ROOT.join('config', 'database')

Twitter.configure do |config|
  config.consumer_key = "B9PTuH7PuQVwQt5qSlexA"
  config.consumer_secret = "BSMah5siEocr7p7doloiDbBZQfNZBamMV7dUog6Hs"
  config.oauth_token = "864007722-T8UUdEOk1XndTfDN1MhhWoo1XIRbJTEu9TdHt07R"
  config.oauth_token_secret = "ibwNozdELuZI0iZCI4IZ6F1OvxfvFFW6trUzQNdX5gU"
end

use OmniAuth::Builder do
  # For additional provider examples please look at 'omni_auth.rb'
  # provider :google_oauth2, '631878338394.apps.googleusercontent.com', 'sterRGO4MJHBiqyLXbT0eart', {}
  # provider :twitch_oauth2, 'kwh498lg2c4p659yx8ng713d00q3rjp', 'ks6u1x5w2g69zk8txwjzyi1s407dqzu', {scope: "user_read user_blocks_edit user_blocks_read user_follows_edit channel_read channel_editor channel_commercial channel_stream channel_subscriptions channel_check_subscription chat_login"}
  provider :twitter, 'B9PTuH7PuQVwQt5qSlexA', 'BSMah5siEocr7p7doloiDbBZQfNZBamMV7dUog6Hs'
end
