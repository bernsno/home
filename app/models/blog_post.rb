class BlogPost < ActiveRecord::Base
	
	UPLOAD_LIMIT = 5
	
  # VALIDATIONS
	validates_presence_of :title, :body, :intro
	
	# ASSOCIATIONS
	
	# NAMED SCOPES
	# TODO: How to handle publish bool and publish date
	named_scope :publishable, :conditions => { :publish => true }
	named_scope :by_publish_date, :order => "publish_date DESC"
	
	
	# PAPERCLIP
	has_attached_file :image,
                    :styles => {
                      :thumb => "75x75#",
                      :gallery_thumbnail => "150x150#",
                      :interactive => "400x450#"
                    },
                    :default_style => :thumb
  
  validates_attachment_thumbnails :image
  validates_attachment_content_type :image, :content_type => [/image/], :message => "is not an image."
  validates_attachment_size :image, :in => 1..UPLOAD_LIMIT.megabytes
	
	# INSTANCE METHODS
	def to_param
    "#{id}-#{title.parameterize}"
  end

  # CLASS METHODS
  def self.per_page
    10
  end

end

# GENERAL BLOG TODOS:

# TODO: RSS/ATOM FEED
# TODO: PERMALINKS?
# TODO: PUBLISH DATE
# TODO: SHARE THIS
# TODO: **COMMENTS**

# BLOG PREFERENCES
# PER PAGE
# *COMMENTS*
# IMAGE SIZES