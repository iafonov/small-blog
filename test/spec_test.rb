require 'rubygems'
require 'sinatra'
require 'sinatra/test/rspec'

load 'main.rb'

describe 'My fucking site' do
  print $LOAD_PATH

  it 'should show the about me page with my nice face' do
    get '/blog'
    print @response.inspect
    @response.should be_ok    
  end

end
