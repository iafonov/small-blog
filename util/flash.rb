require 'sinatra'

def get_flash
  flash = request.cookies["flash"]
  response.delete_cookie("flash")
  return flash  
end

def set_flash(message)
  set_cookie("flash", :value => message, :path => '/')
end
