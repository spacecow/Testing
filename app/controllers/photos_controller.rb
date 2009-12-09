class PhotosController < ApplicationController
	filter_resource_access
	
  def new
  	@photo = Photo.new( :gallery_id => params[:gallery_id])
  end
  
  def create
    if @photo.save
  		render :action => "crop"
    else
      render :action => 'new'
    end
  end

	def edit
	end
  
  def update
    if @photo.update_attributes( params[:photo] )
      if( params[:photo][:photo].blank? )
      	flash[:notice] = t('photos.notice.add_success')
      	redirect_to @photo.gallery
    	else
    		render :action => "crop"
  		end
    else
      render :action => 'edit'
    end
  end
  
  def show
  	count = 1
  	while !Photo.exists?( @photo.id+count )
  		count+=1
  		count = -@photo.id+1 if( count > Photo.last.id )
  	end
 		@next = Photo.find( @photo.id+count )
	end

  def destroy
    gallery = @photo.gallery
    @photo.destroy
    flash[:notice] = t('photos.notice.delete_success')
    redirect_to gallery
  end	
end