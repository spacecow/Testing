class Teaching < ActiveRecord::Base
  belongs_to :teacher, :class_name => 'User'
  belongs_to :klass
  
  before_create :set_cost
  before_create :set_status_mask
  
  STATUS = %w[confirmed declined unconfirmed taught canceled untaught]
  
  def confirmed_symbol
  	if status? :confirmed
  		"O"
  	elsif status? :declined
  		"X"
		else
  		"?"
		end
  end

  def taught_symbol
  	if status? :taught
  		"O"
  	elsif status? :canceled
  		"X"
		else
  		"?"
		end
  end
  
  def confirm
    #status? :confirmed
  end
  
  def confirm=( value )
    if value.blank?
      reset_status :declined
      add_status :unconfirmed
    elsif value=="confirmed"
      reset_status :unconfirmed
      add_status :confirmed
      add_status :untaught
    elsif value=="declined"
      reset_status :confirmed
      reset_status :untaught
      add_status :declined
    end
    save!
  end
  
  def taught=( value )
    if value.blank?
      reset_status :canceled
      add_status :untaught
    elsif value=="taught"
      reset_status :untaught
      add_status :taught
    elsif value=="canceled"
      reset_status :taught
      add_status :canceled
    end
    save!
  end
  

  def reset_status( value )
    self.status_mask &= 2**STATUS.size-1 - status_value( value )
  end

  def add_status( value )
    self.status_mask |= status_value( value )
  end

  def status?( value )
    status.include?( value.to_s )
  end
  
  def status_value( value )
    index = STATUS.index( value.to_s )
    index.nil? ? 0 : 2**index
  end
  
  def status
    STATUS.reject {|r| ((status_mask || 0) & 2**STATUS.index(r)).zero? }
  end	
  
  def status=( value )
    self.status_mask = (value & STATUS).map {|r| 2**STATUS.index(r)}.sum
  end

	def to_s
		klass.to_s
	end
	
private

	def set_cost
		hour = ( klass.duration/3600 ).round
		course_teacher = teacher.courses_teachers.select{|e| e.course_id==klass.course.id}.first
		self.cost = course_teacher.cost.to_i * hour unless course_teacher.nil?
	end
	
	def set_status_mask
		add_status :unconfirmed
	end
end
