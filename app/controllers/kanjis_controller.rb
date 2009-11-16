class KanjisController < ApplicationController
  def index
    @kanjis = Kanji.all
  end
  
  def show
    @kanji = Kanji.find(params[:id])
    random = rand(2)
    options = [ @kanji.katakana, @kanji.kanji ]
    replace = "<font color=\"red\"><strong>#{options[random]}</strong></font>"
    @question = @kanji.japanese.gsub( @kanji.kanji,replace );
    @correct_answer = options[1-random];
  end
  
  def check
  	@kanji = Kanji.find(params[:id])
  	answer = params[:answer]
  	correct_answer = params[:correct_answer]
  	if( answer == correct_answer )
  		flash[:notice] = "Correct!<br>#{@kanji.english}"
  	else
  		flash[:error] = "Wrong! The correct answer was: #{correct_answer}."
		end
  	redirect_to Kanji.find( rand( Kanji.count )+1 )
  end
  
  def new
    @kanji = Kanji.new
  end
  
  def create
    @kanji = Kanji.new(params[:kanji])
    if @kanji.save
      flash[:notice] = "Successfully created kanji."
      redirect_to new_kanji_path
    else
      render :action => 'new'
    end
  end
  
  def edit
    @kanji = Kanji.find(params[:id])
  end
  
  def update
    @kanji = Kanji.find(params[:id])
    if @kanji.update_attributes(params[:kanji])
      flash[:notice] = "Successfully updated kanji."
      redirect_to edit_kanji_path( @kanji.id+1 )
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @kanji = Kanji.find(params[:id])
    @kanji.destroy
    flash[:notice] = "Successfully destroyed kanji."
    redirect_to kanjis_url
  end
end
