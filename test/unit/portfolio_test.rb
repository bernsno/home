require File.dirname(__FILE__) + '/../test_helper'

class PortfolioTest < ActiveSupport::TestCase

  # VALIDATIONS
	should_validate_presence_of :name

	# ASSOCATIONS
	should_have_many :portfolio_pieces

	# NAMED SCOPES

	# INSTANCE METHODS

end