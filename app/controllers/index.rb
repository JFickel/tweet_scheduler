get '/' do
  erb :index
end

post '/tweets' do
  Twitter.update(params[:tweet])
end
