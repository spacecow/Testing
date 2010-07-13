class StoriesController < ApplicationController
  def index
    @stories = Story.all
  end
  
  def show
    @story = Story.find(params[:id])
  end
  
  def new
    @story = Story.new
  end
  
  def create
    @story = Story.new(params[:story])
    if @story.save
      flash[:notice] = "Successfully created story."
      redirect_to @story
    else
      render :action => 'new'
    end
  end
  
  def edit
    @story = Story.find(params[:id])
  end
  
  def update
    @story = Story.find(params[:id])
    if @story.update_attributes(params[:story])
      flash[:notice] = "Successfully updated story."
      redirect_to @story
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @story = Story.find(params[:id])
    @story.destroy
    flash[:notice] = "Successfully destroyed story."
    redirect_to stories_url
  end
  
  def quiz_init
  	if params[:story_id].blank?
  		story_ids = Story.all( :select=>'id' ).map(&:id)
    	@story = Story.find( rand( story_ids.length )+1 )
  	else
  		@story = Story.find( params[:story_id] )
		end
		session[:story_id] = @story.id
  	session[:question] = @story.english
  	session[:correct_answer] = @story.japanese
  	p @story.japanese
  	session[:part_answer] = session[:correct_answer].gsub(/[^。、・]/,'＊')
  	redirect_to quiz_stories_path
  end
  
  def quiz
  	@story = Story.find( session[:story_id] )
  	@question = session[:question]
  	@part_answer = session[:part_answer]
  	@correct_answer = session[:correct_answer]
  end
  
  def check
  	redirect_to quiz_init_stories_path and return if params[:answer] == "skip"    
    session[:part_answer] = update_answer( session[:correct_answer], params[:answer ], session[:part_answer])
		if session[:question] != params[:question]
			Story.find( session[:story_id] ).update_attribute(:english,params[:question])
			session[:question] = params[:question]
		end
  	redirect_to quiz_init_stories_path and return if session[:part_answer] == session[:correct_answer]
  	redirect_to quiz_stories_path
  end
  
  
  
  
  def update_answer( correct_answer, answer, part_answer )
  	new_part_answer = correct_answer.gsub(/#{answer}/, answer.gsub(/./,'*'))
    new_parts = new_part_answer.split(//)
    corrects = correct_answer.split(//)
    parts = part_answer.split(//)
    
    new_parts.each_with_index do |part,i|
    	if part=="*"
    		parts[i] = corrects[i]
  		end
    end

		parts.join
  end
end
