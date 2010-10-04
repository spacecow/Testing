class Event < ActiveRecord::Base
	has_many :registrants, :dependent => :destroy
	has_many :users, :through => :registrants
  has_many :comments, :dependent => :destroy
  has_one :gallery, :dependent => :destroy

	attr_accessible :title_en, :title_ja, :start_date, :end_date, :due_date, :description_en, :description_ja, :place, :cost, :pay_method
  
  validates_presence_of :title_en, :title_ja
	validates_uniqueness_of :title_en, :title_ja
	
	before_save :check_pay_method
	
	def cost_to_s
		return I18n.t( :to_be_announced ) if cost.blank?
		cost
	end
	
	def date
		return I18n.t( :to_be_announced ) if start_date.nil?
		ret = start_date_and_time
		return ret+" - ?" if end_date.nil?
		if start_date.strftime("%x") == end_date.strftime("%x")
			ret += " - "+end_time
		elsif start_date.year == end_date.year
			ret += " - "+non_year_end_date_and_time
		else
			ret += " - "+year_end_date_and_time
		end
		ret
	end
	
	def year_date_and_time( category )
		"#{year_date_to_s( category )} #{time_to_s( category )}"
	end	
	
	def non_year_date_and_time( category )
		"#{non_year_date_to_s( category )} #{time_to_s( category )}"
	end		
	
	def date_and_time( category )
		"#{date_to_s( category )} #{time_to_s( category )}"
	end		
	
	
	
	def description( japanese )
		japanese ? description_ja : description_en
	end
	
	def due_date_and_time
		return I18n.t( :to_be_announced ) if due_date.nil?
		"#{date_and_time( 'due' )}"
	end
	
	
	
	def year_end_date_and_time
		"#{year_date_and_time( 'end' )}"
	end	
	
	def non_year_end_date_and_time
		"#{non_year_date_and_time( 'end' )}"
	end		
	
	def end_date_and_time
		"#{date_and_time( 'end' )}"
	end		
	
	def end_time
		"#{time_to_s( 'end' )}"
	end
	
	
	
	def pay_method_to_s
		return I18n.t( :to_be_announced ) if pay_method.blank?
		pay_method
	end
	
	def place_to_s
		return I18n.t( :to_be_announced ) if place.blank?
		place
	end
	
	
	
	def year_start_date_and_time
		"#{year_date_and_time( 'start' )}"
	end
	
	def start_date_and_time
		"#{date_and_time( 'start' )}"
	end	
	
	def start_date_to_s
		return I18n.t( :to_be_announced ) if start_date.blank?
		"#{date_to_s('start')}"
	end
	
	
	
	def title( japanese )
		japanese ? title_ja : title_en
	end	
	
private

	def non_year_date_to_s( category )
		send( "month_to_s", category ).to_s+"/"+send( "day_to_s", category ).to_s
	end
	def year_date_to_s( category )
		send( "year_to_s", category ).to_s+"-"+non_year_date_to_s( category )
	end
	def date_to_s( category )
		Date.current.year == year_to_s( category ) ? non_year_date_to_s( category ) : year_date_to_s( category )
	end	
	
	
	def year_to_s( category )
		send( "#{category}_date" ).year
	end
	def month_to_s( category )
		month = send( "#{category}_date" ).month
		return "0"+month.to_s if month<10
		month
	end	
	def day_to_s( category )
		day = send( "#{category}_date" ).day
		return "0"+day.to_s if day<10
		day
	end		
	def time_to_s( category )
		send( "hour_to_s", category ).to_s+":"+send( "min_to_s", category ).to_s
	end
	def hour_to_s( category )
		hour = send( "#{category}_date" ).hour
		return "0"+hour.to_s if hour<10
		hour
	end
	def min_to_s( category )
		min = send( "#{category}_date" ).min
		return "0"+min.to_s if min<10
		min
	end	
	
	def check_pay_method
		self.pay_method = "none" if cost=="free"
	end
end




























# == Schema Information
#
# Table name: events
#
#  id                :integer(4)      not null, primary key
#  created_at        :datetime
#  updated_at        :datetime
#  title_ja          :string(255)
#  description_ja    :text
#  title_en          :string(255)
#  description_en    :text
#  registrants_count :integer(4)      default(0)
#  place             :string(255)
#  start_date        :datetime
#  end_date          :datetime
#  pay_method        :string(255)
#  due_date          :datetime
#  cost              :string(255)
#

