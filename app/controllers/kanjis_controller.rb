class KanjisController < ApplicationController
	load_and_authorize_resource
	
  def index
    @kanjis = Kanji.all
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    if @kanji.save
      flash[:notice] = 'Kanji was successfully created.'
      redirect_to @kanji
    else
      render :action => "new"
    end
  end

  def update
    if @kanji.update_attributes(params[:kanji])
      flash[:notice] = 'Kanji was successfully updated.'
      redirect_to @kanji
    else
      render :action => "edit"
    end
  end

  def destroy
    @kanji.destroy
    flash[:notice] = "Successfully destroyed kanji."
    redirect_to kanjis_url
  end
  
  def authorize
  end  
  def authorize_view
  end      
end
