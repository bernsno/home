module EnumFieldTest
	def should_enumerate_fields(field, invalid_string="paosdkfaksdfpoaksdf")
		klass = model_class
    constant = eval("#{klass}::#{field.to_s.pluralize.upcase.constantize}")

    should_allow_values_for :template, constant
  	constant.each do |t|
      should_have_instance_methods "#{t}?"
    end
    should_not_allow_values_for :template, invalid_string, :message => /invalid/

	end
end

class Test::Unit::TestCase #:nodoc:
  extend EnumFieldTest
end