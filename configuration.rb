configure :development do
  ActiveRecord::Base.establish_connection(
    :adapter => 'mysql',
    :encoding =>  'utf8',
    :username => 'root',
    :host => 'localhost',
    :socket => '/var/lib/mysql/mysql.sock',
    :database => 'blog_development'
  )

  enable :sessions
end

configure :test do
  ActiveRecord::Base.establish_connection(
    :adapter => 'mysql',
    :encoding =>  'utf8',
    :username => 'root',
    :host => 'localhost',
    :socket => '/var/lib/mysql/mysql.sock',
    :database => 'blog_development'
  )

  enable :sessions
end

configure :development_home do #home
  ActiveRecord::Base.establish_connection(
    :adapter => 'mysql',
    :encoding =>  'utf8',
    :username => 'root',
    :password => '1',
    :host => 'localhost',
    :socket => '/var/run/mysqld/mysqld.sock',
    :database => 'blog_development'
  )  

  enable :sessions
end