class GlossariesController < ApplicationController
  load_and_authorize_resource

  def quiz
    @glossary = Glossary.find( params[:glossary_id] )
    @question = params[:question]
    @word = params[:word]
    @glossary.japanese.gsub!(/(#{@word})/,'<b><font color="red">\1</font></b>')
    @index = params[:index].to_i
    @correct_answer = Kanji.find_by_title(@word).meanings.map(&:title).join(", ")
    @part_answer = params[:part_answer]
    #@kanji = Kanji.find( params[:kanji_id] )

    ##kanjis = @glossary.japanese.split(//)
    ##begin
    ##  @kanji = Kanji.find_by_title( kanjis[@index] )
    ##  @index+=1
    ##end while ( @index < kanjis.size && !@kanji ) # && !@kanji )
  end

  def quiz_init
  	@glossary = case params[:glossary_id]
  	when nil
  		gs = Glossary.all( :select=>'id' ).map(&:id)
    	Glossary.find( gs[rand(gs.length)] )
    else
    	Glossary.find( params[:glossary_id] )
    end	
    
		kanji, index = get_kanji_index( @glossary, params[:index] )
    
    correct_answer = kanji.meanings.map(&:title).join(", ")
    part_answer = correct_answer.gsub(/\w/,'*')
    
    redirect_to quiz_glossaries_path(
    	:glossary_id => @glossary.id,
    	:word => kanji.title,
    	:index => index,
    	:question => "Meaning?",
    	:part_answer => part_answer
    )
  end

	def get_kanji_index( glossary, index )
    kanjis = glossary.japanese.split(//)
    index = ( index || -1 ).to_i
    begin
      kanji = Kanji.find_by_title( kanjis[index+=1] )
    end while ( index < kanjis.size && kanji.nil? )
		[kanji, index]
	end

	def check
    @index = params[:index]    
    @answer = params[:answer]
    @word = params[:word]
    @index = params[:index]
    @part_answer = params[:part_answer]
    @correct_answer = Kanji.find_by_title(@word).meanings.map(&:title).join(", ")
    
    @new_part_answer = @correct_answer.gsub(/#{@answer}/, @answer.gsub(/./,'*'))
    new_parts = @new_part_answer.split(//)
    corrects = @correct_answer.split(//)
    parts = @part_answer.split(//)
    
    new_parts.each_with_index do |part,i|
    	if part=="*"
    		parts[i] = corrects[i]
  		end
    end

    @part_answer = parts.join

		if @part_answer==@correct_answer
			redirect_to quiz_init_glossaries_path(
				:glossary_id => @glossary.id,
				:index => @index,
				:word => @word
			) and return
		end
    
    respond_to do |format|
      format.html{ redirect_to quiz_glossaries_path(
      	:glossary_id => params[:glossary_id],
      	:word => params[:word],
      	:question => params[:question],
      	:index => @index,
      	:part_answer => @part_answer
      )}
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
