require 'rubygems'
require 'RMagick'
require 'util/util.rb'

class Image    
  attr_accessor :image_path
  attr_accessor :path

  @@exif_date_format = '%Y:%m:%d %H:%M:%S'


  def initialize(path_to_gallery, image)    
    @image_path = image
    @path = path_to_gallery        
    #@image = Magick::Image.read(path).first
  end

  def preview_path
    "#{@path}/previews/#{@image_path}"
  end

  def path
    "#{@path}/#{@image_path}"
  end

  def date_taken            
    #date  = @image.get_exif_by_entry('DateTime')[0][1]        
    #date = DateTime.strptime(date, @@exif_date_format) if date        
    #date.strftime('%d %m %Y')    
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
      gallery_relative_path = "gallery/#{gallery}"
      gallery_absolute_path = relative_to_absolute(gallery_relative_path)
      
      if File.directory?(gallery_absolute_path)
        gallery = Gallery.new(gallery)

        Dir.foreach(gallery_absolute_path) do |image|
          gallery.images << Image.new(gallery_relative_path, image) if valid?(image)          
        end

        @galleries << gallery
      end
    end
  end  

  haml :gallery
end