class PortfolioPiece < ActiveRecord::Base
	
	validates_presence_of :title
	
	belongs_to :portfolio
	
	
	def self.per_page
		10
	end
end
