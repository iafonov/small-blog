def connect_to_db(mode)
  ActiveRecord::Base.establish_connection(
    :adapter => 'mysql',
    :encoding =>  'utf8',
    :username => 'root',
    #:password => '1',
    :host => 'localhost',
    :socket => '/var/lib/mysql/mysql.sock',
    #:socket => '/var/run/mysqld/mysqld.sock',
    :database => 'blog_' + mode.to_s
  )
end

def common_config(mode)
  connect_to_db(mode)

  enable :sessions
end

configure :development do  
  common_config(:development)
end

configure :test do
  common_config(:test)
end