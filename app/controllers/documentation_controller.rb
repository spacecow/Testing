class DocumentationController < ApplicationController
  layout 'courses'
  
  def live_search
  	@docs = Doc.all(
     :conditions => [ "docs.id = docs_tags.doc_id and docs_tags.tag_id = tags.id and tags.name like (?) or docs.title like (?)", "%"+params[:search_text]+"%", "%"+params[:search_text]+"%" ],
     :include => 'tags' )
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
