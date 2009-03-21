xml.instruct! :xml, :version=>"1.0" 
xml.rss(:version=>"2.0"){
  xml.channel{
    xml.title("")
    xml.link("")
    xml.description("")
    xml.language('en-us')
    xml.link formatted_blog_post_url(:rss)
      for blog_post in @blog_posts
        xml.item do
          xml.title(blog_post.title)
          xml.pubDate(blog_post.created_at.strftime("%a, %d %b %Y %H:%M:%S %z"))
          xml.link(blog_post_url(blog_post))
					xml.description(blog_post.intro)
        end
      end
  }
}