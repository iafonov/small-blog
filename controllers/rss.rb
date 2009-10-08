get '/rss.xml' do
  posts = Post.all(:order => 'created_at DESC')

  builder do |xml|
    xml.instruct! :xml, :version => '1.0'
    xml.rss :version => "2.0" do
      xml.channel do
        xml.title "Igor's Blog"
        xml.description "Blog about nothing"
        xml.link "http://localhost:4567/"
        
        posts.each do |post|
          xml.item do
            xml.title post.title
            xml.link "http://localhost:4567/posts/#{post.id}"
            xml.description format(post.body)
            xml.pubDate Time.parse(post.created_at.to_s).rfc822()
            xml.guid "http://localhost:4567/posts/#{post.id}"
          end
        end
      end
    end
  end
end
