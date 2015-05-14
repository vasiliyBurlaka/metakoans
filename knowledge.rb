def attribute a, &block
		
	define_method :initialize do
		instance_variable_set("@#{a}", instance_eval(&block)) if block_given? 
		if a.class == Hash
			a.each { |key,val|
			  instance_variable_set("@#{key}", val)
			}
		end
	end

	if a.class == Hash
		a.each { |key,val|
		  add_set_get_query key
		}
	else
		add_set_get_query a
	end

end


def add_set_get_query a
  define_method a do
  	instance_variable_get("@#{a}")
  end

  define_method "#{a}?" do 
    true && instance_variable_get("@#{a}")
  end

  define_method "#{a}=" do |val|
    instance_variable_set("@#{a}", val)
  end
end