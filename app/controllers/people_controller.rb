class PeopleController < ApplicationController
  def live_search
    render :partial => 'list',  
      :locals => { :searchtext=>params[:search_text], :category=>params[:category] }
  end

  # GET /people
  # GET /people.xml
  def index
    @people = Person.find(:all)
    @category = params[:category] || "全部の人"
    session[:redirect] = request.request_uri

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @people }
    end
  end

  # GET /people/1
  # GET /people/1.xml
  def show
    @person = Person.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @person }
    end
  end

  # GET /people/new
  # GET /people/new.xml
  def new
    @person = Person.new( :ritei=>false, :inactive=>false )

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @person }
    end
  end

  # GET /people/1/edit
  def edit
    @person = Person.find(params[:id])
  end

  # POST /people
  # POST /people.xml
  def create
    @person = Person.new(params[:person])
		@person.tostring = @person.to_s

    respond_to do |format|
      if @person.save
        flash[:notice] = ( @person.teacher!=nil ? 'Teacher' : 'Student' )+' was successfully created.'
	      format.html { redirect_to( session[:redirect] || people_path ) }
        format.xml  { render :xml => @person, :status => :created, :location => @person }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @person.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /people/1
  # PUT /people/1.xml
  def update
    @person = Person.find(params[:id])
    
    respond_to do |format|
      if @person.update_attributes(params[:person])
        @person.update_attribute( :tostring, @person.to_s )
	    if @person.user_name == session[:user_name]
		  session[:user] = Person.find_by_user_name( session[:user_name] )		
	    end

       # if @person.teacher != nil
	    #    flash[:notice] = 'Teacher was successfully updated.'
	   #     format.html { redirect_to( teachers_path ) }
        if @person.teacher == nil
	        flash[:notice] = 'Student was successfully updated.'
	        format.html { redirect_to( people_path ) }
	      else        
	        flash[:notice] = 'Person was successfully updated.'
	        format.html { redirect_to( people_path ) }
	      end
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @person.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.xml
  def destroy
    @person = Person.find(params[:id])
    if @person.teacher != nil
      @person.teacher.destroy
    end
    if @person.student != nil
      @person.student.destroy
    end
    @person.destroy

    respond_to do |format|
      format.html { redirect_to(session[:redirect] || people_url) }
      format.xml  { head :ok }
    end
  end

protected
  def authorize
    unless Person.find_by_user_name( session[:user_name] )
      session[:original_uri] = request.request_uri
      flash[:notice] = "Please log in"
      redirect_to :controller=>:admin, :action=>:login
    end
  end
end 