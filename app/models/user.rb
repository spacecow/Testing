class User < ActiveRecord::Base
	include NameValidations
	
	has_many :registrants, :dependent => :destroy
	has_many :events, :through => :registrants
	has_many :comments, :dependent => :destroy
	has_many :sent_invitations, :class_name => 'Invitation', :foreign_key => 'sender_id'
	has_many :todos
	has_many :votes, :dependent => :destroy
	belongs_to :invitation
  has_many :photos
  has_many :reset_passwords
  has_many :mails, :foreign_key => "recipient_id"
  
  named_scope :with_role, lambda { |role| {:conditions => "roles_mask & #{2**ROLES.index(role.to_s)} > 0"} }
  
  attr_accessible :username, :email, :invitation_token, :nationality, :name, :password, :password_confirmation, :language, :male, :name_hurigana, :occupation, :tel, :age, :roles, :roles_mask, :new_registrant_attributes, :christmas, :info_update, :change_password, :avatar
  
  #before_create :set_invitation_limit
  before_create :set_role
  
	acts_as_authentic

  has_attached_file :avatar, :styles => {
	  	:mini =>  { :geometry => "40x40#",   :processors => [:cropper]},
	  	:small => { :geometry => "100x100#", :processors => [:cropper]},
	  	:large => { :geometry => "500x500>" }},
  	:url  => "/assets/avatars/:id/:style/:basename.:extension",
    :path => ":rails_root/public/assets/avatars/:id/:style/:basename.:extension"
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :reprocess_avatar, :if => :cropping?
	#attr_protected :avatar_file_name, :avatar_content_type, :avatar_size
  
	# Attachment validations that doesnt work
  #validates_attachment_size :avatar, :less_than => 5.megabytes, :if => :avatar_file_name
	#validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png', 'image/jpg']	
	#validates_inclusion_of :avatar_content_type, :in => %w( image/jpeg image/png ), :message => "is not a picture", :if => :false
	
  validates_uniqueness_of :username
	validates_presence_of :name, :name_hurigana, :language, :nationality
	validates_inclusion_of :male, :in => [false, true]
	validates_presence_of :occupation, :age, :tel, :if => :christmas	
	attr_accessor :christmas, :change_password

	validates_presence_of :invitation_id, :message => 'is required'
	validates_uniqueness_of :invitation_id
	
	validates_presence_of :password,	 :if => :change_password
	
	#attr_accessible :username, :email, :password, :password_confirmation, :roles_mask, :role, :name, :invitation_token
	
	ROLES = %w[god admin observer teacher student registrant photographer]
	LANGUAGES_EN = [['Japanese','ja'],['English','en']]
	LANGUAGES_JA = [['日本語','ja'],['英語','en']]

	def role_symbols
    roles.map(&:to_sym)
    #roles.include? role.to_s
  end
  
  def role?( role )
  	roles.include? role.to_s
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

	def invitation_token
		invitation.token if invitation	
	end

	def unread_mail?
		mails.map(&:read).grep(false).size > 0
	end
	
	def invitation_token=(token)
		self.invitation = Invitation.find_by_token( token )
	end
  
  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end
  def roles
    ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  end

	def to_s
		name  	
	end  
private
  def reprocess_avatar
    avatar.reprocess!
  end
  
  def set_invitation_limit
    self.invitation_limit = 0;
  end
  
  def set_role
		self.roles = ["registrant"]
	end
end
