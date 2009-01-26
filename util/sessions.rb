def authenticate(password)
  if 'fuck' == password then
    session["i_am"] = true
    return true
  else
    return false
  end
end

def logout
  session["i_am"] = false
end

def secure
  redirect '/' if not @is_admin
end
