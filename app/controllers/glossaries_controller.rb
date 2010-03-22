class GlossariesController < ApplicationController
  load_and_authorize_resource

  def quiz
    @glossary = Glossary.find( params[:glossary_id] )
    @index = params[:index].to_i
    @correct_answer = params[:correct_answer]
    @part_answer = params[:part_answer]
    @kanji = Kanji.find( params[:kanji_id] )
    #kanjis = @glossary.japanese.split(//)
    #begin
    #  @kanji = Kanji.find_by_title( kanjis[@index] )
    #  @index+=1
    #end while ( @index < kanjis.size && !@kanji ) # && !@kanji )
  end

  def quiz_init
    
    @glossary = Glossary.find( rand( Glossary.count )+1 )
    kanjis = @glossary.japanese.split(//)
    index = 0
    begin
      @kanji = Kanji.find_by_title( kanjis[index] )
      index+=1
    end while ( index < kanjis.size && !@kanji ) # && !@kanji )
    @part_answer = ""
    @kanji.onyomis.map{|e| e.reading.size/3 }.sum.times{ @part_answer += "*" }
    
    #@glossary_hash = {}
    #@glossary.japanese.split(//).each do |kanji_title|
    #  if kanji = Kanji.find_by_title( kanji_title )
    #    @glossary_hash[kanji_title] = kanji
    #  end 
    #end
    
    redirect_to quiz_glossaries_path( :glossary_id => @glossary.id, :index => 0, :kanji_id => @kanji.id, :correct_answer => @kanji.onyomis.map(&:reading), :part_answer=>@part_answer )
  end

	def check
    @correct_answer = params[:correct_answer]
    @part_answer = params[:part_answer]
    @answer = params[:answer]
    
    @new_part_answer = @correct_answer.gsub(/#{@answer}/, '*')
    new_parts = @new_part_answer.split(//)
    corrects = @correct_answer.split(//)
    parts = @part_answer.split(//)
    p new_parts
    p parts
    
    new_parts.each_with_index do |part,i|
    	if part=="*"
    		parts[i] = corrects[i]
  		end
    end
		p parts

    @part_answer = parts.join
    
    respond_to do |format|
      format.html{ redirect_to quiz_init_glossaries_path }
      format.js
    end	
	end

  def index
    @glossaries = Glossary.all
  end
  
  def show
  	@glossary = Glossary.find( params[:id] )
  end
  
  def new
    @glossary = Glossary.new
  end
  
  def create
    @glossary = Glossary.create( params[:glossary] )
    if @glossary.save
      redirect_to new_glossary_path
    else
      render :action => 'new'
    end
  end
  
  def edit
  	@glossary = Glossary.find( params[:id] )
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
