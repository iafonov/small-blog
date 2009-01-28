class Gallery
  attr_accessor :name
  attr_accessor :images
  attr_accessor :previews

  def initialize(name)
    @name = name
    @images = Array.new
    @previews = Array.new
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

      gallery_path = File.join(Dir.pwd, "public/gallery/#{gallery}")
      if File.directory?(gallery_path)
        gallery = Gallery.new(gallery)

        Dir.foreach(gallery_path) do |image|          
          gallery.images << image if valid?(image)
        end

        Dir.foreach("#{gallery_path}/previews") do |preview|
          gallery.previews << preview if valid?(preview)
        end

        @galleries << gallery
      end
    end
  end

  puts @galleries.inspect

  haml :gallery
end