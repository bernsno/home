require File.dirname(__FILE__) + '/../test_helper'

class PortfolioPieceTest < ActiveSupport::TestCase

  # VALIDATIONS
	should_validate_presence_of :title

	# ASSOCATIONS
	should_belong_to :portfolio

	# NAMED SCOPES

	# INSTANCE METHODS

	# WILL PAGINATE
	should_have_per_page 10
	
	# PAPERCLIP
	should_have_attached_file :image
	should_validate_attachment_size :image, :in => 1..BlogPost::UPLOAD_LIMIT.megabytes

end