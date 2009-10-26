module Enumerable
  def uniq_by #:yield:
    h = {}; inject([]) {|a,x| h[yield(x)] ||= a << x}
  end
end

class SchedulesController < ApplicationController
  def index
    @schedules = Schedule.all
  end
  
  def show
    @schedule = Schedule.find(params[:id])
  end
  
  def new
    @schedule = Schedule.new
    @courses = Course.all
    @units = []
    @scheduled_units = []
  end
  
  def create
    @schedule = Schedule.new(params[:schedule])
    @courses = Course.all
    @units = []
    @scheduled_units = []
    if @schedule.save
      flash[:notice] = t('schedule')+t('created')
      redirect_to schedules_url
    else
      render :action => 'new'
    end
  end
    
  def edit
    @schedule = Schedule.find( params[:id], :include=>:scheduled_units )
    @courses = Course.all
		@units = Unit.all
			
#		@classes = Klass.course_name( @schedule.course_name ).
#			all( :conditions=>[ "date > ?", 1.day.ago ]).
#			uniq_by( &:date_and_time_interval )

		@scheduled_units = []
    #generate_scheduled_units( @schedule )
	end
  
  def update
    @schedule = Schedule.find(params[:id])
    @courses = Course.all
    if @schedule.update_attributes(params[:schedule])
      flash[:notice] = "Successfully updated schedule."
      redirect_to :back
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy
    flash[:notice] = "Successfully destroyed schedule."
    redirect_to schedules_url
  end
  
	def generate_scheduled_units( schedule )
		scheduled_units = []
		template_hash = TemplateClass.all(
			:conditions=>["courses.name = ?", schedule.course.name],
			:include => :course
		).uniq_by( &:day_and_time_interval ).
			group_by( &:day )
			
		index = 0
		(0..90).to_a.map{|e| e.day.from_now }.each do |date|
			elements = template_hash[ date.strftime("%A") ]
			unless elements.nil?
				elements.sort_by( &:time_interval ).each do |e|
					break if( index += 1 ) > units_per_schedule
					
					scheduled_unit = schedule.get_scheduled_unit( date, e.start_time, e.end_time	)
					old_scheduled_unit = schedule.get_scheduled_unit( date - 7.days, e.start_time, e.end_time )
					unit_id = old_scheduled_unit ? ( old_scheduled_unit.unit_id ? old_scheduled_unit.unit_id+1 : nil ) : nil # = @classes[ equal_array.index( true ) ]
					if scheduled_unit.nil?
						scheduled_unit = ScheduledUnit.create!(
							:date => date,
							:start_time => e.start_time,
							:end_time => e.end_time,
							:unit_id => unit_id
						)
						schedule.scheduled_units << scheduled_unit
					else
						unless old_scheduled_unit.nil? || scheduled_unit.unit_id == unit_id
							scheduled_unit.update_attribute( :unit_id, unit_id ) 
						end
					end
					scheduled_units.push scheduled_unit 
				end
			end
		end
		scheduled_units
	end  
end