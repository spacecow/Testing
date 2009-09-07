class SchedulesController < ApplicationController
  def index
    @schedules = Schedule.all
  end
  
  def show
    @schedule = Schedule.find(params[:id])
	  @day_groups = TemplateClass.all(
	    :conditions=>["courses.name=?", @schedule.title ],
	    :include=>'course' ).group_by(&:day)
	    

		@day_hash = {}
		@day_groups.each do |day,group|
			hash = Hash.new
			array = Array.new
			group.sort_by(&:time_interval).reverse.each do |klass|
				unless hash[klass.time_interval]
					hash[klass.time_interval] = klass
	      	array.insert( 0, klass.time_interval )
				end
			end
			@day_hash[day] = array
		end

	    
  end
  
  def new
    @schedule = Schedule.new
  end
  
  def create
    @schedule = Schedule.new(params[:schedule])
    if @schedule.save
      flash[:notice] = "Successfully created schedule."
      redirect_to schedules_url
    else
      render :action => 'new'
    end
  end
  
  def edit
    @schedule = Schedule.find(params[:id])
  end
  
  def update
    @schedule = Schedule.find(params[:id])
    if @schedule.update_attributes(params[:schedule])
      flash[:notice] = "Successfully updated schedule."
      redirect_to @schedule
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
