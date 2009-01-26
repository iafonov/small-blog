def connect_to_db(mode)
  ActiveRecord::Base.establish_connection(
    :adapter => 'mysql',
    :encoding =>  'utf8',
    :username => 'root',
    :host => 'localhost',
    :socket => '/var/lib/mysql/mysql.sock',
    :database => 'blog_' + mode.to_s
  )
end

configure :development do  
  connect_to_db :development

  enable :sessions
end

configure :test do
  connect_to_db :test

  enable :sessions
end

# configure :development_home do #home
#   ActiveRecord::Base.establish_connection(
#     :adapter => 'mysql',
#     :encoding =>  'utf8',
#     :username => 'root',
#     :password => '1',
#     :host => 'localhost',
#     :socket => '/var/run/mysqld/mysqld.sock',
#     :database => 'blog_development'
#   )  

#   enable :sessions
# end