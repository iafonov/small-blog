root_dir = File.expand_path("#{File.dirname(__FILE__)}/..").sub(/^#{Dir.getwd}/, '.')

puts root_dir

$:.unshift "#{root_dir}/sinatra/lib" if File.exist?("#{root_dir}/sinatra")
$:.unshift "#{root_dir}/lib"
$:.unshift "#{root_dir}/test"

require 'rubygems'
require 'spec/interop/test'
require 'sinatra/test/unit'

load 'main.rb'

describe 'my application' do
  it 'should show redirect to about page if accessed from root context' do
    get '/'
    
    @response.should be_redirect    
    original_headers["Location"].should == '/about'


  end

  it 'should show navigation panel on about page' do
    get '/about'
    
    response.should have_tag('div')
  end

end
