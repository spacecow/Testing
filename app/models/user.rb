# -*- coding: utf-8 -*-
class User < ActiveRecord::Base
  include NameValidations

  has_many :bank
  accepts_nested_attributes_for :bank

  has_many :courses_teachers, :dependent => :destroy, :foreign_key=>'teacher_id'
  has_many :teacher_courses, :through=>:courses_teachers, :source=>'course'
  accepts_nested_attributes_for :courses_teachers, :reject_if => lambda{|a| a['chosen']=="0"}, :allow_destroy=>true

  has_and_belongs_to_many :student_courses, :join_table => 'courses_students', :foreign_key => 'student_id', :class_name=>'Course'

  has_many :attendances, :dependent => :destroy, :foreign_key => 'student_id'
  has_many :student_klasses, :through => :attendances, :source => 'klass'
  has_many :teachings, :dependent => :destroy, :foreign_key => "teacher_id"
  has_many :teacher_klasses, :through => :teachings, :source => 'klass'
  accepts_nested_attributes_for :teachings

  has_many :registrants, :dependent => :destroy
  has_many :events, :through => :registrants
  has_many :comments, :dependent => :destroy
  has_many :sent_invitations, :class_name => 'Invitation', :foreign_key => 'sender_id'
  has_many :todos
  has_many :votes, :dependent => :destroy
  belongs_to :invitation
  has_many :photos
  has_many :reset_passwords

  has_many :recipients, :dependent => :destroy
  has_many :mails, :through => :recipients #, :foreign_key => "sender_id"

  named_scope :with_role, lambda { |role| {:conditions => "roles_mask & #{2**ROLES.index(role.to_s)} > 0"} }
  named_scope :not_staff, {:conditions => "cost > 0"}

  #attr_accessible :username, :email, :invitation_token, :nationality, :name, :password, :password_confirmation, :language, :male, :name_hurigana, :occupation, :tel, :age, :roles, :roles_mask, :new_registrant_attributes, :christmas, :info_update, :change_password, :avatar

  #before_create :set_invitation_limit
  before_create :set_role

  acts_as_authentic

  has_attached_file :avatar, :styles => {
    :micro =>  { :geometry => "30x30#",   :processors => [:cropper]},
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

  validates_presence_of :password, :if => :change_password

  #attr_accessible :username, :email, :password, :password_confirmation, :roles_mask, :role, :name, :invitation_token

  ROLES = %w[god admin observer teacher student registrant photographer beta-tester]
  LANGUAGES_EN = [['Japanese','ja'],['English','en']]
  LANGUAGES_JA = [['日本語','ja'],['英語','en']]
  STATUS_DROP = [
                 ["all", "all"],
                 ["teachers.title","teacher"],
                 ["students.title","student"],
                ]
  STATUS_HASH = {"teacher"=>"teachers.title", "student"=>"students.title"}

  def already_reserved?( klass )
    student_klasses.include?( klass )
  end

  def not_enrolled?( course )
    !student_courses.include?( course )
  end

  def already_reserved_instance?( string,id )
    student_klasses.reject{|e| e.id==id }.map(&:to_s).include?( string )
  end
  
  #--------------------

  def avatar_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(avatar.path(style))
  end

  def self.beta_testers
    Rails.cache.fetch( 'beta_testers' ){ all( :select => 'name, id, current_login_at' ) }
  end

  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end

  def has_traveling_expenses
    traveling_expenses.to_i > 0
  end

  def new_registrant_attributes=( registrant_attributes )
    registrant_attributes.each do |attributes|
      registrants.build( attributes )
    end
  end


  def invitation_token
    invitation.token if invitation
  end

  def unread_mail?
    recipients.map(&:read).grep(false).size > 0
  end

  def invitation_token=(token)
    self.invitation = Invitation.find_by_token( token )
  end

  #-------------------- Roles

  def role?( role )
    roles.include? role.to_s
  end

  def role_symbols
    roles.map(&:to_sym)
    #roles.include? role.to_s
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
    self.roles = ["registrant", "student"]
  end
end

# == Schema Information
#
# Table name: users
#
#  id                  :integer(4)      not null, primary key
#  username            :string(255)
#  email               :string(255)
#  crypted_password    :string(255)
#  password_salt       :string(255)
#  persistence_token   :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  roles_mask          :integer(4)
#  role                :string(255)
#  occupation          :string(255)
#  name                :string(255)
#  name_hurigana       :string(255)
#  male                :boolean(1)
#  age                 :string(255)
#  tel                 :string(255)
#  nationality         :string(255)
#  language            :string(255)
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer(4)
#  avatar_updated_at   :datetime
#  invitation_id       :integer(4)
#  invitation_limit    :integer(4)
#  login_count         :integer(4)      default(0), not null
#  failed_login_count  :integer(4)      default(0), not null
#  current_login_at    :datetime
#  last_login_at       :datetime
#  current_login_ip    :string(255)
#  last_login_ip       :string(255)
#  info_update         :boolean(1)      default(TRUE)
#  cost                :string(255)
#  traveling_expenses  :string(255)
#

