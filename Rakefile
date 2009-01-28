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
  GALLERY_IMAGES_DIR = "public/gallery"

  def create_thumbnail(image, gallery_name)    
    if (image.columns >=  image.rows) 
      crop_factor = image.rows
    else 
      crop_factor = image.columns 
    end

    preview = image.crop_resized(crop_factor, crop_factor, Magick::NorthGravity)
    preview.thumbnail!(100, 100)
    
    filename = File.basename(image.base_filename)
    FileUtils.mkdir_p File.join(Dir.pwd, "#{GALLERY_IMAGES_DIR}/#{gallery_name}/previews")
    preview.write("#{GALLERY_IMAGES_DIR}/#{gallery_name}/previews/#{filename}") { self.quality = 80 }    
  end

  def create_resized_image(image, gallery_name)
    photo = image.resize_to_fit(800, 800)
    filename = File.basename(image.base_filename)
    FileUtils.mkdir_p File.join(Dir.pwd, "#{GALLERY_IMAGES_DIR}/#{gallery_name}")
    photo.write("#{GALLERY_IMAGES_DIR}/#{gallery_name}/#{filename}") { self.quality = 75 }
  end

  def process_directory(dir, gallery_name)    
    Dir.foreach(dir) do |image|    
      if (image.include? ".jpg")
        puts "Processing #{dir}/#{image}" 
        
        image = Magick::Image.read("#{dir}/#{image}").first        
        create_thumbnail(image, gallery_name)
        create_resized_image(image, gallery_name)        
      end
    end
  end

  desc "Fill gallery with images."
  task 'fill' do
    unless ENV.include?("src")
      raise "usage rake gallery:fill src= #folder with images"
    end

    FileUtils.rm_rf GALLERY_IMAGES_DIR
    FileUtils.mkdir_p GALLERY_IMAGES_DIR

    src_dir = ENV["src"]    

    Dir.foreach(src_dir) do |gallery_dir|  
      gallery_path = File.join(File.join(Dir.pwd, src_dir), gallery_dir)      
      if (File.directory?(gallery_path))        
        process_directory(gallery_path, gallery_dir)  
      end
    end
  end
end

namespace 'gems' do
  desc "Fucked target/In progress."
  task :install do
    sh 'cd /tmp; sudo gem install rack haml rmagick'
  end
end
