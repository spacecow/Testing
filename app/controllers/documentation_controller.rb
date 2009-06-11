class DocumentationController < ApplicationController
  layout 'courses'
  
  def live_search
    render :partial => 'hits',  
      :locals => { :searchtext=>params[:search_text] }
  end
  
  def index
  end

  def display_document
    @doc = Doc.find( params[:doc_id] )
    #render :layout => 'documentation'
    respond_to do |format|
    	format.js
    end
  end

end
