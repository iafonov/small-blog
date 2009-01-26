require 'rubygems'
require 'spec/rake/spectask'
require 'sinatra'


Spec::Rake::SpecTask.new do |t|
  t.ruby_opts = ['-rtest/unit']
  t.spec_files = FileList['test/**/*_test.rb']
end



namespace 'db' do
  task :create do  
    require 'activerecord'
  
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

namespace 'gems' do
  task :install do

  end
end
