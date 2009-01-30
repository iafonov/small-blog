require 'rubygems'
require 'RMagick'

class Image  
  EXIF_DATE_FORMAT = '%Y:%m:%d %H:%M:%S'  

  attr_accessor :image_path
  attr_accessor :path

  def initialize(path_to_gallery, image)    
    @image_path = image
    @path = path_to_gallery    
    @image = Magick::Image.read(File.join(Dir.pwd, "public/" + path)).first
  end

  def preview_path
    "#{@path}/previews/#{@image_path}"
  end

  def path
    "#{@path}/#{@image_path}"
  end

  def date_taken        
    date  = @image.get_exif_by_entry('DateTime')[0][1]    
    DateTime.strptime(date, EXIF_DATE_FORMAT) if date    
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

  Dir.foreach("public/gallery") do |gallery|
    if (gallery != ".") && (gallery != "..")      
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