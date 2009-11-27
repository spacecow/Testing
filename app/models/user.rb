class User < ActiveRecord::Base
	acts_as_authentic  
	
	#attr_accessible :username, :email, :password, :password_confirmation, :roles_mask, :role, :name
	has_many :registrants, :dependent => :destroy
	accepts_nested_attributes_for :registrants, :allow_destroy => true
	has_many :events, :through => :registrants
  
	
	validates_uniqueness_of :username
	validates_presence_of :name, :role
	validates_inclusion_of :male, :in => [false, true]
	
	validates_presence_of :occupation, :age, :tel, :if => :christmas
	validates_presence_of :name_hurigana, :if => :japanese
	validates_presence_of :nationality, :if => :english
	
	attr_accessor :christmas, :english, :japanese
	
	ROLES = %w[god admin observer teatcher student registrant]
	LANGUAGES = [['Japanese','ja'],['English','en']]

	def role_symbols
    [role.to_sym]
  end
	
  #def roles=(roles)
  #  self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  #end
  #def roles
  #  ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  #end

end
