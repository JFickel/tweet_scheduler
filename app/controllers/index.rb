get '/' do
  if @user = params[:twitter_username]
    redirect "/#{@user}"
  else
    erb :index
  end
end

get '/:username' do
 puts params[username]
#mkae an api call to grab 10 recent tweets from user name
  erb :view_tweets
end
