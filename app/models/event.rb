class Event < ActiveRecord::Base
	has_many :registrants, :dependent => :destroy
	has_many :users, :through => :registrants
  has_many :comments

	attr_accessible :title, :date, :description
  
  validates_presence_of :title, :date
	validates_uniqueness_of :title  
end
