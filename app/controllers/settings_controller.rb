class SettingsController < ApplicationController
	load_and_authorize_resource
	
  def index
    @settings = Setting.all
  end
  
  def show
    @setting = Setting.find(params[:id])
  end
  
  def new
    @setting = Setting.new
  end
  
  def create
    @setting = Setting.new(params[:setting])
    if @setting.save
      flash[:notice] = "Successfully created setting."
      redirect_to settings_url
    else
      render :action => 'new'
    end
  end
  
  def edit
    @setting = Setting.find(params[:id])
  end
  
  def update
    @setting = Setting.find(params[:id])
    if @setting.update_attributes(params[:setting])
      flash[:notice] = "Successfully updated setting."
      redirect_to settings_path
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @setting = Setting.find(params[:id])
    @setting.destroy
    flash[:notice] = "Successfully destroyed setting."
    redirect_to settings_url
  end

  def toggle_user_language
  	@settings = Setting.all
  	session[:language] = ( session[:language] == "en" ? "ja" : "en" )
  	redirect_to :back
	end
	  
  def authorize
  end  
  def authorize_view
	end    
end
