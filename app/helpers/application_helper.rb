module ApplicationHelper
  
  # Sensible flash messages
  def flash_helper(tag = :p)
    flash.collect do |fl|
      content_tag(tag, fl.last, :class => "#{fl.first} flash")
    end
  end
  
end