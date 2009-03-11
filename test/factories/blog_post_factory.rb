Factory.define :blog_post do |b|
  b.title "Super Blog Post"
  b.intro "Please"
  b.body "we do have some great food"
  b.publish true
	b.publish_date Time.now
	b.image_file_name "picture.png"
	b.image_content_type "image/png"
	b.image_file_size 1
	b.image_updated_at Time.now
end