class User < ActiveRecord::Base
	has_many :registrants, :dependent => :destroy
	has_many :events, :through => :registrants
	has_many :comments, :dependent => :destroy

	acts_as_authentic

  has_attached_file :avatar, :styles => { :mini => "40x40#", :small => "100x100#", :large => "500x500>" }, :processors => [:cropper]
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :reprocess_avatar, :if => :cropping?
	#attr_protected :avatar_file_name, :avatar_content_type, :avatar_size
  
	validates_attachment_size :avatar, :less_than => 5.megabytes
	validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png']	
	validates_uniqueness_of :username
	validates_presence_of :name, :role, :name_hurigana, :language, :nationality
	validates_inclusion_of :male, :in => [false, true]
	validates_presence_of :occupation, :age, :tel, :if => :christmas	
	attr_accessor :christmas	
	
	#attr_accessible :username, :email, :password, :password_confirmation, :roles_mask, :role, :name
	
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
  
  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end
  
  def avatar_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(avatar.path(style))
  end
  
  private
  
  def reprocess_avatar
    avatar.reprocess!
  end

  #def roles=(roles)
  #  self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  #end
  #def roles
  #  ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  #end

end
