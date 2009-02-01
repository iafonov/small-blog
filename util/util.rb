def relative_to_absolute(path)
  File.join(Dir.pwd, "public", path)
end