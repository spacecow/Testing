class GlossariesController < ApplicationController
  load_and_authorize_resource

  def quiz
    @glossary = Glossary.find( params[:glossary_id] )
    @question = params[:question]
    @word = params[:word]
    @glossary.japanese.gsub!(/(#{@word})/,'<b><font color="red">\1</font></b>')
    @start_index = params[:start_index].to_i
    @end_index = params[:end_index].to_i
    @correct_answer = Word.find_by_japanese(@word).meaning.gsub(/\(.+?\)/,"")
    @part_answer = params[:part_answer]
    #@kanji = Kanji.find( params[:kanji_id] )

    ##kanjis = @glossary.japanese.split(//)
    ##begin
    ##  @kanji = Kanji.find_by_title( kanjis[@index] )
    ##  @index+=1
    ##end while ( @index < kanjis.size && !@kanji ) # && !@kanji )
  end

	def banned?( word )
		banned = {
			"の"=>"banned",
			"は"=>"banned",
			"み"=>"banned",
			"べ"=>"banned",
			"お"=>"banned",
			"です"=>"banned",
			"で"=>"banned",
			"ない"=>"banned",
			"シス"=>"banned",
			"シ"=>"banned",
			"ステム"=>"banned",
			"な"=>"banned",
			"い"=>"banned",
			"ボー"=>"banned",
			"ー"=>"banned",
			"が"=>"banned",
			"を"=>"banned",
			"って"=>"banned",
			"て"=>"banned",
			"ぞ"=>"banned",
			"どう"=>"banned",
			"ど"=>"banned",
			"わ"=>"banned",
			"に"=>"banned",
			"さ"=>"banned",
			"し"=>"banned",
			"々"=>"banned",
			"え"=>"banned"
		}
		return true if word.nil?
		return true if banned[word.japanese]
		false
	end

  def quiz_init
  	@glossary = case params[:glossary_id]
  	when nil
  		gs = Glossary.all( :select=>'id' ).map(&:id)
    	Glossary.find( gs[rand(gs.length)] )
    else
    	Glossary.find( params[:glossary_id] )
    end	
    
    kanjis = @glossary.japanese.split(//)
    start_index = ( params[:start_index] || 0 ).to_i
  	end_index = ( params[:end_index] || [kanjis.size, 8].min ).to_i
    begin
      end_index-=1
      if start_index > end_index
    		end_index = kanjis.size-1
    		start_index+=1
    	end
    	if start_index > end_index
    		gs = Glossary.all( :select=>'id' ).map(&:id)
    		@glossary = Glossary.find( gs[rand(gs.length)] )
		    kanjis = @glossary.japanese.split(//)
		    start_index = 0
		  	end_index = [kanjis.size-1, 8].min
  		end
      word = Word.find_by_japanese( kanjis[start_index..end_index].join )
    end while ( banned?(word) && start_index <= end_index )
		    
    correct_answer = word.meaning.gsub(/\(.+?\)/,"")
    part_answer = correct_answer.gsub!(/\w/,'*')
    
    redirect_to quiz_glossaries_path(
    	:glossary_id => @glossary.id,
    	:word => word.japanese,
    	:start_index => start_index,
    	:end_index => end_index,
    	:question => "Meaning?",
    	:part_answer => part_answer
    )
  end

	def check
    @start_index = params[:start_index] 
    @end_index = params[:end_index]   
    @answer = params[:answer]
    @word = params[:word]
    @part_answer = params[:part_answer]
    @correct_answer = Word.find_by_japanese(@word).meaning
        
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

		if @part_answer==@correct_answer || @answer=="skip"
			redirect_to quiz_init_glossaries_path(
				:glossary_id => @glossary.id,
				:start_index => @start_index,
				:end_index => @end_index,
				:word => @word
			) and return
		end
    
    respond_to do |format|
      format.html{ redirect_to quiz_glossaries_path(
      	:glossary_id => params[:glossary_id],
      	:word => params[:word],
      	:question => params[:question],
      	:start_index => @start_index,
      	:end_index => @end_index,
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
