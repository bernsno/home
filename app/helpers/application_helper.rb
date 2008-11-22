module ApplicationHelper

  def set_title(title)
    @title = title
  end
  
  def title
    title = Settings.site_name
    title += "- #{@title}" if @title
  end
  
  def body_class
    controller.controller_path.gsub(/\//,'-').downcase
  end
  
  # Sensible flash messages
  def flash_helper(tag = :p)
    flash.collect do |fl|
      content_tag(tag, html_escape(fl.last), :class => "#{fl.first} flash")
    end
  end
  
end