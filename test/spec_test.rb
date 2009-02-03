require 'helper.rb'

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
