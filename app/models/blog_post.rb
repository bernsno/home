class BlogPost < ActiveRecord::Base

	UPLOAD_LIMIT = 5
	
  # VALIDATIONS
	validates_presence_of :title, :body, :intro
	
	# ASSOCIATIONS
	
	# NAMED SCOPES
	named_scope :publishable, :conditions => { :publish => true }
	
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