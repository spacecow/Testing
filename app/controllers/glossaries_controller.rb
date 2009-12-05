class GlossariesController < ApplicationController
  filter_resource_access

  def index
    @glossaries = Glossary.all
  end
  
  def show
  end
  
  def new
  end
  
  def create
    if @glossary.save
      flash[:notice] = "Successfully created glossary."
      redirect_to glossaries_url
    else
      render :action => 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @glossary.update_attributes(params[:glossary])
      flash[:notice] = "Successfully updated glossary."
      redirect_to @glossary
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @glossary.destroy
    flash[:notice] = "Successfully destroyed glossary."
    redirect_to glossaries_url
  end
  
  def authorize
  end  
  def authorize_view
  end      
end
