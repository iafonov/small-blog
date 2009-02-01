get '/login' do
  haml :login
end

post '/login' do
  if authenticate(params["password"])
    redirect '/'
  else
    'Fuck you bitch!'
  end
end

get '/logout' do
  logout
  redirect '/'
end

get '/version' do
  Sinatra::VERSION
end