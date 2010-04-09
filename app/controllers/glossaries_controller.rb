class GlossariesController < ApplicationController
  load_and_authorize_resource

  def quiz
    @glossary = Glossary.find( params[:glossary_id] )
    @question = params[:question]
    @word = params[:word]
    @glossary.japanese.gsub!(/(#{@word})/,'<b><font color="red">\1</font></b>')
    @start_index = params[:start_index].to_i
    @end_index = params[:end_index].to_i
    @part_answer = params[:part_answer]
    p @kunyomi = params[:kunyomi].to_i
    #@kanji = Kanji.find( params[:kanji_id] )
        
    if @question[0..7] == "Reading?"
    	@correct_answer = case @start_index == @end_index
  		when false; to_hiragana(Word.find_by_japanese(@word).reading)
  		when true; to_hiragana( Kanji.find_by_title(@word).kunyomis[@kunyomi].reading )
			end
  	else
  		@correct_answer = Word.find_by_japanese(@word).meaning.gsub(/\(.+?\)/,"")
		end

    ##kanjis = @glossary.japanese.split(//)
    ##begin
    ##  @kanji = Kanji.find_by_title( kanjis[@index] )
    ##  @index+=1
    ##end while ( @index < kanjis.size && !@kanji ) # && !@kanji )
  end

	def hiragana?( letter )
		hiragana = {
"ぁ"=>"xa", "あ"=>"a", "ぃ"=>"xi", "い"=>"i", "ぅ"=>"xu", "う"=>"u", "ぇ"=>"xe", "え"=>"e", "ぉ"=>"xo",
"お"=>"o", "か"=>"ka", "が"=>"ga", "き"=>"ki", "ぎ"=>"gi", "く"=>"ku", "ぐ"=>"gu", "け"=>"ke", "げ"=>"ge", "こ"=>"ko", "ご"=>"go", "さ"=>"sa", "ざ"=>"za", "し"=>"shi", "じ"=>"ji", "す"=>"su", "ず"=>"zu", "せ"=>"se", "ぜ"=>"ze", "そ"=>"so", "ぞ"=>"zo", "た"=>"ta",
"だ"=>"da", "ち"=>"chi", "ぢ"=>"di", "っ"=>"xtsu", "つ"=>"tsu", "づ"=>"du", "て"=>"te", "で"=>"de", "と"=>"to", "ど"=>"do", "な"=>"na", "に"=>"ni", "ぬ"=>"nu", "ね"=>"ne", "の"=>"no", "は"=>"ha",
"ば"=>"ba", "ぱ"=>"pa", "ひ"=>"hi", "び"=>"bi", "ぴ"=>"pi", "ふ"=>"hu", "ぶ"=>"bu", "ぷ"=>"pu", "へ"=>"he", "べ"=>"be", "ぺ"=>"pe", "ほ"=>"ho", "ぼ"=>"bo", "ぽ"=>"po", "ま"=>"ma", "み"=>"mi",
"む"=>"mu", "め"=>"me", "も"=>"mo", "ゃ"=>"xya", "や"=>"ya", "ゅ"=>"xyu", "ゆ"=>"yu", "ょ"=>"xyo", "よ"=>"yo", "ら"=>"ra", "り"=>"ri", "る"=>"ru", "れ"=>"re", "ろ"=>"ro", "ゎ"=>"xwa", "わ"=>"wa",
"ゐ"=>"wi", "ゑ"=>"wu", "を"=>"wo", "ん"=>"n"
		}
		return true if hiragana[letter]
	end
	
	def to_hiragana( word )
		hiragana = {
"ぁ"=>"xa", "あ"=>"a", "ぃ"=>"xi", "い"=>"i", "ぅ"=>"xu", "う"=>"u", "ぇ"=>"xe", "え"=>"e", "ぉ"=>"xo",
"お"=>"o", "か"=>"ka", "が"=>"ga", "き"=>"ki", "ぎ"=>"gi", "く"=>"ku", "ぐ"=>"gu", "け"=>"ke", "げ"=>"ge", "こ"=>"ko", "ご"=>"go", "さ"=>"sa", "ざ"=>"za", "し"=>"shi", "じ"=>"ji", "す"=>"su", "ず"=>"zu", "せ"=>"se", "ぜ"=>"ze", "そ"=>"so", "ぞ"=>"zo", "た"=>"ta",
"だ"=>"da", "ち"=>"chi", "ぢ"=>"di", "っ"=>"xtsu", "つ"=>"tsu", "づ"=>"du", "て"=>"te", "で"=>"de", "と"=>"to", "ど"=>"do", "な"=>"na", "に"=>"ni", "ぬ"=>"nu", "ね"=>"ne", "の"=>"no", "は"=>"ha",
"ば"=>"ba", "ぱ"=>"pa", "ひ"=>"hi", "び"=>"bi", "ぴ"=>"pi", "ふ"=>"hu", "ぶ"=>"bu", "ぷ"=>"pu", "へ"=>"he", "べ"=>"be", "ぺ"=>"pe", "ほ"=>"ho", "ぼ"=>"bo", "ぽ"=>"po", "ま"=>"ma", "み"=>"mi",
"む"=>"mu", "め"=>"me", "も"=>"mo", "ゃ"=>"xya", "や"=>"ya", "ゅ"=>"xyu", "ゆ"=>"yu", "ょ"=>"xyo", "よ"=>"yo", "ら"=>"ra", "り"=>"ri", "る"=>"ru", "れ"=>"re", "ろ"=>"ro", "ゎ"=>"xwa", "わ"=>"wa",
"ゐ"=>"wi", "ゑ"=>"wu", "を"=>"wo", "ん"=>"n"
		}
		hiraganad = word.split(//).map{|e| hiragana[e]}.join
		hiraganad.gsub(/jixy/,'j').gsub(/hixy/,'h').gsub(/ixy/,'y').gsub(/xtsu(\w)/,'\1\1')
	end
	
	def banned?( word )
		return true if word.nil?
		banned = {
			"シス"=>"banned",
			"ステム"=>"banned",
			"シ"=>"banned"
		}
		return false if word.instance_of? Kanji
		return true unless banned[word.japanese].nil?
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
    
    question = params[:question] || "Meaning?"
    kanjis = @glossary.japanese.split(//)
    start_index = ( params[:start_index] || 0 ).to_i
  	end_index = ( params[:end_index] || [kanjis.size,start_index+5].min ).to_i
    
    if question[0..7] == "Meaning?"
	    begin
	    	while hiragana? kanjis[start_index]
	    		start_index+=1
    			end_index = [end_index+1,kanjis.size].min
	    	end
	    	
	      end_index-=1
	      if start_index > end_index
	    		end_index = [kanjis.size-1,start_index+5].min
	    		start_index+=1
	    	end
	    	if start_index > end_index
	    		gs = Glossary.all( :select=>'id' ).map(&:id)
	    		@glossary = Glossary.find( gs[rand(gs.length)] )
			    kanjis = @glossary.japanese.split(//)
			    start_index = 0
			  	end_index = kanjis.size-1
	  		end
	  		if start_index == end_index
	  			word = Kanji.find_by_title( kanjis[start_index] )
	  			correct_answer = to_hiragana( word.kunyomis[0].reading )
	  			question = "Reading? (#{word.kunyomis[0].reading.gsub(/(.+)\./,word.title)})"
	  			kunyomi = 0
	      else
	      	word = Word.find_by_japanese( kanjis[start_index..end_index].join )
	      	correct_answer = to_hiragana(word.reading) unless word.nil?
	      	question = "Reading?"
      	end
	    end while ( banned?(word) && start_index <= end_index )	  	
	  	

    else
    	word = Word.find_by_japanese( kanjis[start_index..end_index].join )
    	correct_answer = word.meaning.gsub(/\(.+?\)/,"")
    	question = "Meaning? (#{word.reading})"	
    end
    part_answer = correct_answer.gsub!(/\w/,'*')
    
    redirect_to quiz_glossaries_path(
    	:glossary_id => @glossary.id,
    	:word => word.instance_of?(Word) ? word.japanese : word.title,
    	:start_index => start_index,
    	:end_index => end_index,
    	:question => question,
    	:part_answer => part_answer,
    	:kunyomi => kunyomi
    )
  end

	def check
    @start_index = params[:start_index] 
    @end_index = params[:end_index]   
    @answer = params[:answer]
    @word = params[:word]
    @part_answer = params[:part_answer]
    @question = params[:question]

    if @question == "Reading?"
    	@correct_answer = to_hiragana(Word.find_by_japanese(@word).reading)
  	else
  		@correct_answer = Word.find_by_japanese(@word).meaning.gsub(/\(.+?\)/,"")
		end

        
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
				:question => @question,
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
      	:question => @question,
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
