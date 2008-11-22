identify_dir = File.dirname(%x[which convert])
convert_dir = File.dirname(%x[which identify])

if (Rails.env.development? || Rails.env.test?)
  Paperclip.options[:image_magick_path] = '/usr/local/bin/'
elsif !(identify_dir.blank? && convert_dir.blank?) && (identify_dir == convert_dir)
  Paperclip.options[:image_magick_path] = identify_dir
else
  Paperclip.options[:image_magick_path] = '/usr/bin/'
end