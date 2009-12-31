module NameValidations

	def self.included( my_class )
		my_class.send( :validate_on_create,	:check_name_is_allowed )
	end
	
	RESTRICTED_NAMES = %w{ admin webmaster mydomain.com	superuser	}

private
	def check_name_is_allowed
		RESTRICTED_NAMES.each do |restricted|
			errors.add( :username, "is not available" ) if
				username =~ /#{restricted}/i
		end
		RESTRICTED_NAMES.each do |restricted|
			errors.add( :name, "is not available" ) if
				name =~ /#{restricted}/i
		end		
	end
end