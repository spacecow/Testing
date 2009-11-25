class User < ActiveRecord::Base
  acts_as_authentic  
	attr_accessible :username, :email, :password, :password_confirmation, :roles_mask, :role
	
	ROLES = %w[god admin observer teatcher student]

	def role_symbols
		p "FUCK ME!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		p role.to_sym
    [role.to_sym]
  end

	
  #def roles=(roles)
  #  self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  #end
  #def roles
  #  ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  #end

end
