class Portfolio < ActiveRecord::Base

	validates_presence_of :name

	has_many :portfolio_pieces
	
end
