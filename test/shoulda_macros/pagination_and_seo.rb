module OneDesign

	# def should_parameterize(field)
	# 	klass = model_class
	# 	context "should parameterize" do
	# 		setup do
	# 			@object = get_instance_of(klass)
	# 		end
	# 		should "find id and title for params" do
	# 			assert_equal @object.to_param, "#{@object.object_id}-#{@object.send(field).parameterize}"
	# 		end
	# 	end
	# end
	
	def should_have_per_page(count) 
		klass = model_class
		context "#{klass}" do 
			should "respond to per_page" do 
				assert klass.respond_to?(:per_page), "#{klass} does not respond to :per_page" 
			end 

			should "have #{count} per page" do 
				assert_equal count, klass.per_page 
      end 
    end 
  end
end

class Test::Unit::TestCase #:nodoc:
 extend OneDesign
end
