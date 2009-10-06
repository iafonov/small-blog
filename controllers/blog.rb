require 'rubygems'
require 'sinatra'
require 'activerecord'

require 'model/schema.rb'

require 'util/flash.rb'
require 'util/sessions.rb'

get '/blog' do
  @posts = Post.all(:order => 'created_at DESC')
  haml :blog, :layout => :layout_blog
end

get '/posts/add' do secure 
  haml :post_add
end

post '/posts/add' do secure
  Post.create(params[:post])
  set_flash 'New post created'
  redirect '/blog'
end

get '/posts/edit/:id' do secure  
  @post = Post.find(params[:id])
  haml :post_edit
end

post '/posts/edit/:id' do secure 
  post = Post.find(params[:id])
  post.title = params[:title]
  post.body = params[:body]
  post.save
  set_flash 'Post updated'
  redirect '/blog'
end

get '/posts/delete/:id' do secure
  Post.delete(params[:id])
  set_flash 'Post was deleted'
  redirect '/blog'
end

get '/posts/:id' do
  @post = Post.find(params[:id])  
  haml :post_view, :layout => :layout_blog
end

post '/posts/:id/add_comment' do
  post = Post.find(params[:id])
  post.comments.create(params[:comment])
  set_flash 'Comment added'
  redirect '/posts/' + params[:id]
end