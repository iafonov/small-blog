require 'rubygems'
require 'sinatra'
require 'RMagick'

namespace 'db' do
  desc "Create db schema"
  task :create do  
    require 'activerecord'
    require 'configuration'    

    ActiveRecord::Base.establish_connection(
      :adapter => 'mysql',
      :encoding =>  'utf8',
      :username => 'root',
      :host => 'localhost',
      :socket => '/var/lib/mysql/mysql.sock',
      :database => 'blog_development'
    )
  
    ActiveRecord::Migration.create_table :posts do |t|
      t.string :title
      t.text :body
  
      t.timestamps
    end
  
    ActiveRecord::Migration.create_table :comments do |t|      
      t.text :body
      t.integer :post_id
  
      t.timestamps
    end
  end
end

namespace 'gallery' do
  GALLERY_PREVIEW_DIR = "public/gallery/previews"
  GALLERY_IMAGES_DIR = "public/gallery"

  desc "Fill gallery with images."
  task 'fill' do
    unless ENV.include?("src")
      raise "usage rake gallery:fill src= #folder with images"
    end

    src_dir = ENV["src"]    

    Dir.foreach(src_dir) {|image_file|
      if (image_file != '.' and image_file != '..')  
        puts "Processing #{image_file}" 
        
        image = Magick::Image.read("#{src_dir}/#{image_file}").first

        preview = image.crop_resized(100, 100, Magick::NorthGravity)     
        preview.write("#{GALLERY_PREVIEW_DIR}/#{image_file}") { self.quality = 70 }

        photo = image.resize_to_fit(1024, 1024)
        photo.write("#{GALLERY_IMAGES_DIR}/#{image_file}") { self.quality = 80 }
      end
    }
  end
end

namespace 'gems' do
  desc "Fucked target/In progress."
  task :install do
    sh 'cd /tmp; sudo gem install rack haml rmagick'
  end
end
