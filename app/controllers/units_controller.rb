class UnitsController < ApplicationController
  def index
    @units = Unit.all( :include => :schedule )
  end
  
  def show
    @unit = Unit.find(params[:id])
  end
  
  def new
    @unit = Unit.new
    @schedules = Schedule.all
  end
  
  def create
    @unit = Unit.new(params[:unit])
    @schedules = Schedule.all
    if @unit.save
      flash[:notice] = "Successfully created unit."
      redirect_to units_path
    else
      render :action => 'new'
    end
  end
  
  def edit
    @unit = Unit.find(params[:id])
    @schedules = Schedule.all
  end
  
  def update
    @unit = Unit.find(params[:id])
    @schedules = Schedule.all
    if @unit.update_attributes(params[:unit])
      flash[:notice] = "Successfully updated unit."
      redirect_to @unit
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @unit = Unit.find(params[:id])
    @unit.destroy
    flash[:notice] = "Successfully destroyed unit."
    redirect_to units_url
  end
end
