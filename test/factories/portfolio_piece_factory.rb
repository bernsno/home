Factory.define :portfolio_piece do |p|
  p.title "Super Post"
  p.description "we do have some great food"
	p.image_file_name "picture.png"
	p.image_content_type "image/png"
	p.image_file_size 1
	p.image_updated_at Time.now
end