class PhotosController < ApplicationController
	filter_resource_access
	
  def new
  end
  
  def create
    if @photo.save
  		render :action => "crop"
    else
      render :action => 'new'
    end
  end
end