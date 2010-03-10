class Teaching < ActiveRecord::Base
  belongs_to :teacher, :class_name => 'User'
  belongs_to :klass
  
  def confirm
  	status_mask
  end
  
  def confirm=( value )
		#self.status_mask = value[1].to_i
		p "!!!!!!!!!!!!!!!!!!!!!"
		p status_value value[1]
	end
  
  
	STATUS = %w[confirm]
  
  def status_value( status )
  	#sta.include? role.to_s
  	2**STATUS.index( status.to_s )
  end
  
  def status
    STATUS.reject {|r| ((status_mask || 0) & 2**STATUS.index(r)).zero? }
  end	
  
	def status=( status )
    self.status_mask = (status & STATUS).map {|r| 2**STATUS.index(r)}.sum
  end

end
