class Image  
  attr_accessor :image
  attr_accessor :path

  def initialize(path, image)
    @image = image
    @path = path    
  end

  def preview() 
    "#{path}/previews/#{image}"
  end

  def to_s()
    "#{path}/#{image}"
  end
end

class Gallery
  attr_accessor :name

  attr_accessor :images

  def initialize(name)
    @name = name
    @images = Array.new
  end
end

def valid?(image)
  return image.include?(".jpg")
end

get '/gallery' do
  @galleries = Array.new

  puts "shit. works!"

  Dir.foreach("public/gallery") do |gallery|
    if gallery != "." && gallery != ".."
      
      gallery_path = "gallery/#{gallery}"
      gallery_full_path = File.join(Dir.pwd, "public")
      gallery_full_path = File.join(gallery_full_path, "gallery/#{gallery}")
      if File.directory?(gallery_full_path)
        gallery = Gallery.new(gallery)

        Dir.foreach(gallery_full_path) do |image_file|
          gallery.images << Image.new(gallery_path, image_file) if valid?(image_file)          
        end

        @galleries << gallery
      end
    end
  end

  puts @galleries.inspect

  haml :gallery
end