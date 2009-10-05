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
  end
  
  def create
    @schedule = Schedule.new(params[:schedule])
    @courses = Course.all
    @units = []
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

		@scheduled_units = generate_scheduled_units( @schedule )
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
end