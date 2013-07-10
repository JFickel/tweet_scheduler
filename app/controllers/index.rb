get '/' do
  erb :index
end

post '/tweets' do
  user = User.find(session[:user_id])
  user.tweet(params[:tweet])
end

get '/auth/:provider/callback' do
  content_type 'text/plain'
  provider_data = request.env['omniauth.auth'].to_hash.inspect rescue "No Data"
  user = User.find_or_create_by_username(request.env['omniauth.auth'].to_hash['info']['nickname'])
  user.oauth_token = request.env['omniauth.auth'].to_hash['extra']['access_token'].token
  user.oauth_secret = request.env['omniauth.auth'].to_hash['extra']['access_token'].secret
  if user.save
    session[:username] = user.username
    session[:user_id] = user.id
    redirect '/'
  else
    session[:errors] = user.errors
    redirect '/'
  end
end

get '/auth/failure' do
  content_type 'text/plain'
  request.env['omniauth.auth'].to_hash.inspect rescue "No Data"
end

# {"provider"=>"twitter", "uid"=>"864007722", "info"=>{"nickname"=>"jamesfickel",
# "name"=>"James Fickel", "location"=>nil,
# "image"=>"http://a0.twimg.com/sticky/default_profile_images/default_profile_4_normal.png",
# "description"=>nil, "urls"=>{"Website"=>nil, "Twitter"=>"https://twitter.com/jamesfickel"}},
# "credentials"=>{"token"=>"864007722-T8UUdEOk1XndTfDN1MhhWoo1XIRbJTEu9TdHt07R",
# "secret"=>"ibwNozdELuZI0iZCI4IZ6F1OvxfvFFW6trUzQNdX5gU"},
# "extra"=>{"access_token"=>#<OAuth::AccessToken:0x007fb31cd819f0
# @token="864007722-T8UUdEOk1XndTfDN1MhhWoo1XIRbJTEu9TdHt07R",
# @secret="ibwNozdELuZI0iZCI4IZ6F1OvxfvFFW6trUzQNdX5gU",
# @consumer=#<OAuth::Consumer:0x007fb31cd20268 @key="B9PTuH7PuQVwQt5qSlexA",
# @secret="BSMah5siEocr7p7doloiDbBZQfNZBamMV7dUog6Hs",
# @options={:signature_method=>"HMAC-SHA1", :request_token_path=>"/oauth/request_token",
# :authorize_path=>"/oauth/authenticate", :access_token_path=>"/oauth/access_token",
# :proxy=>nil, :scheme=>:header, :http_method=>:post, :oauth_version=>"1.0",
# :site=>"https://api.twitter.com"}, @http=#<Net::HTTP api.twitter.com:443 open=false>,
# @http_method=:post, @uri=#<URI::HTTPS:0x007fb31cd80b18 URL:https://api.twitter.com>>,
#  @params={:oauth_token=>"864007722-T8UUdEOk1XndTfDN1MhhWoo1XIRbJTEu9TdHt07R",
#  "oauth_token"=>"864007722-T8UUdEOk1XndTfDN1MhhWoo1XIRbJTEu9TdHt07R",
#  :oauth_token_secret=>"ibwNozdELuZI0iZCI4IZ6F1OvxfvFFW6trUzQNdX5gU",
#  "oauth_token_secret"=>"ibwNozdELuZI0iZCI4IZ6F1OvxfvFFW6trUzQNdX5gU",
#  :user_id=>"864007722", "user_id"=>"864007722",
#  :screen_name=>"jamesfickel", "screen_name"=>"jamesfickel"},
#  @response=#<Net::HTTPOK 200 OK readbody=true>>,
#  "raw_info"=>{"profile_use_background_image"=>true,
# "screen_name"=>"jamesfickel", "is_translator"=>false,
# "name"=>"James Fickel", "profile_text_color"=>"333333",
# "verified"=>false, "notifications"=>false, "lang"=>"en",
# "contributors_enabled"=>false, "default_profile"=>true,
# "profile_sidebar_border_color"=>"C0DEED", "id"=>864007722,
# "created_at"=>"Sat Oct 06 02:34:14 +0000 2012", "time_zone"=>nil,
# "follow_request_sent"=>false, "profile_background_tile"=>false,
# "listed_count"=>0, "profile_sidebar_fill_color"=>"DDEEF6",
# "profile_image_url_https"=>"https://twimg0-a.akamaihd.net/sticky/default_profile_images/default_profile_4_normal.png",
# "following"=>false, "utc_offset"=>nil,
# "profile_background_image_url_https"=>"https://twimg0-a.akamaihd.net/images/themes/theme1/bg.png",
# "protected"=>false, "profile_background_color"=>"C0DEED", "description"=>nil,
# "profile_image_url"=>"http://a0.twimg.com/sticky/default_profile_images/default_profile_4_normal.png",
# "geo_enabled"=>false, "url"=>nil, "default_profile_image"=>true, "favourites_count"=>0,
# "location"=>nil, "profile_background_image_url"=>"http://a0.twimg.com/images/themes/theme1/bg.png",
# "friends_count"=>14, "statuses_count"=>0, "profile_link_color"=>"0084B4",
# "entities"=>{"description"=>{"urls"=>[]}}, "id_str"=>"864007722", "followers_count"=>3}}}
