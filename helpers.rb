require 'rubygems'
require 'haml'

helpers do
  def partial(page, options={})
    haml ("_" + page.to_s).intern, options.merge!(:layout => false)
  end

  def for_me(text)
    if (@is_admin) then 
      engine = Haml::Engine.new(text)
      return engine.render 
    end
  end
end