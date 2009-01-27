get '/gallery' do
  @images = Array.new
  
  Dir.foreach("public/gallery") {|image_file|    
    if (image_file.include? ".jpg") 
      @images << image_file      
    end
  }

  haml :gallery
end