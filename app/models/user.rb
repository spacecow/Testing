class User < ActiveRecord::Base
	acts_as_authentic  
	
	#attr_accessible :username, :email, :password, :password_confirmation, :roles_mask, :role, :name
	has_many :registrants, :dependent => :destroy
	#accepts_nested_attributes_for :registrants, :allow_destroy => true
	has_many :events, :through => :registrants
  
	
	validates_uniqueness_of :username
	validates_presence_of :name, :role, :name_hurigana, :language, :nationality
	validates_inclusion_of :male, :in => [false, true]
	
	validates_presence_of :occupation, :age, :tel, :if => :christmas
	
	attr_accessor :christmas
	
	ROLES = %w[god admin observer teatcher student registrant]
	LANGUAGES_EN = [['Japanese','ja'],['English','en']]
	LANGUAGES_JA = [['日本語','ja'],['英語','en']]

	def role_symbols
    [role.to_sym]
  end
	
	def new_registrant_attributes=( registrant_attributes )
		registrant_attributes.each do |attributes|
			registrants.build( attributes )	
		end
	end  
  
  #def roles=(roles)
  #  self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  #end
  #def roles
  #  ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  #end

end
