module ApplicationHelper

  def set_title(title)
    @title = title
  end
  
  def title
    returning title = Settings.site_name do
      title += " - #{@title}" if @title
    end
  end
  
  def auth_token
    javascript_tag "var AUTH_TOKEN = #{form_authenticity_token.inspect};" if protect_against_forgery?
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

	def zebra_striped_row(id=nil, options = {})
	  concat("<tr class=\"#{cycle('odd', 'even', :name => options[:name])}\" id=\"#{id}\">")
	  yield
	  concat("</tr>")
  end

  def icon_link(path, image, text, options = {})
		options.reverse_merge!(:class => 'icon_link')
    link_to path, options do
      image_tag(image) + content_tag(:span, h(text))
    end
  end
  
end