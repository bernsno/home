module ActsAsList
	def should_act_as_list
		klass = model_class
		
		context "To support acts_as_list" do
			should_have_db_column('position', :type => :integer)
		end

		should_have_instance_methods :acts_as_list_class, :position_column, :scope_condition
	end
end

class Test::Unit::TestCase #:nodoc:
  extend ActsAsList
end