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
  end
  
  def create
    @schedule = Schedule.new(params[:schedule])
    @courses = Course.all
    if @schedule.save
      flash[:notice] = "Successfully created schedule."
      redirect_to schedules_url
    else
      render :action => 'new'
    end
  end
  
  def edit
    @schedule = Schedule.find(params[:id])
    @courses = Course.all
		@units = []

		@day_hash = {}
		@day_groups = TemplateClass.all(
			:conditions=>["courses.name=?", @schedule.course.name ],
			:include=>'course' ).group_by(&:day)
		@day_groups.each do |day,group|
			hash = Hash.new
			array = Array.new
			group.sort_by(&:time_interval).reverse.each do |klass|
				unless hash[klass.time_interval]
					hash[klass.time_interval] = klass
					array.insert( 0, klass )
				end
			end
			@day_hash[day] = array
		end
		
		(0..9).to_a.map{|e| e.day.from_now }.each do |day|
			elements = @day_hash[day.strftime("%A")]
			unless elements.nil?
				elements.size.times do |no|
					@units.push elements[no]
				end
			end
		end
		
		p @day_hash.values.map(&:size).inject(0){|sum,e| sum + e}
	end
  
  def update
    @schedule = Schedule.find(params[:id])
    @courses = Course.all    
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
