get '/' do
  erb :index
end

post '/tweets' do
  user = Twitter::Client.new(
    :oauth_token => session[:oauth_token],
    :oauth_token_secret => session[:secret_oauth_token]
  )
  user.update(params[:tweet])
end

get '/auth/:provider/callback' do
  content_type 'text/plain'
  provider_data = request.env['omniauth.auth'].to_hash.inspect rescue "No Data"
  session[:oauth_token] = request.env['omniauth.auth'].to_hash['extra']['access_token'].token
  session[:secret_oauth_token] = request.env['omniauth.auth'].to_hash['extra']['access_token'].secret
  redirect '/'
end

get '/auth/failure' do
  content_type 'text/plain'
  request.env['omniauth.auth'].to_hash.inspect rescue "No Data"
end

