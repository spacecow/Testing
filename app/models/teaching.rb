class Teaching < ActiveRecord::Base
  belongs_to :teacher, :class_name => 'User'
  belongs_to :klass
  
  def confirmed_symbol
  	if status? :confirmed
  		"O"
  	else
  		"?"
		end
  end
  
  def confirm
    status? :confirmed
  end
  
  def confirm=( value )
    if value[1].blank?
      reset_status :confirmed
    else    
      add_status :confirmed
    end
  end

  def reset_status( value )
    self.status_mask &= 2**STATUS.size-1 - status_value( value )
  end

  def add_status( value )
    self.status_mask |= status_value( value )
  end
  
  STATUS = %w[confirmed]

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

end
