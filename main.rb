require 'rubygems'
require 'sinatra'
require 'activerecord'

require 'util/flash.rb'

load 'configuration.rb'
load 'helpers.rb'

before do 
  @flash = get_flash
  @is_admin = session["i_am"]
end

get '/style.css' do
  content_type 'text/css'
  sass :style
end

get '/' do
  redirect '/about'
end

load 'login.rb'
load 'about.rb'
load 'gallery.rb'
load 'blog.rb'
