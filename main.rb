require 'rubygems'
require 'sinatra'
require 'activerecord'

require 'util/flash.rb'

load 'config/config.rb'
load 'util/helpers.rb'

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

Dir.foreach("controllers") do |file|   
  load "controllers/#{file}" unless File.directory? file
end