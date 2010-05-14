class CoursesController < ApplicationController
  load_and_authorize_resource
  
  def index
    @sorting = Sorting.new
  	@courses_groups = Course.all( :select=>"name, id, klasses_count, template_classes_count" ).group_by(&:category)
		@keys = @sorting.sort_in_mogi_order( @courses_groups.keys )
  end

  # GET /courses/1
  # GET /courses/1.xml
  def show
    @course = Course.find(params[:id], :include=>[ :klasses, :template_classes ])
  	@sorting = Sorting.new
    @template_klass_groups = @course.template_classes.group_by( &:day )
    @keys = @sorting.sort_by_day @template_klass_groups.keys    
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @course }
    end
  end

  # GET /courses/new
  # GET /courses/new.xml
  def new
    @course = Course.new()

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @course }
    end
  end

  # GET /courses/1/edit
  def edit
    @course = Course.find(params[:id])
  	@sorting = Sorting.new
    @template_klass_groups = @course.template_classes.group_by( &:day )
    @keys = @sorting.sort_by_day @template_klass_groups.keys    
  end

  def create
		if @course.save
      flash[:notice] = t('notice.create_success', :object => t(:course))
      redirect_to @course
    else
      render :action => "new"
    end
  end

  # PUT /courses/1
  # PUT /courses/1.xml
  def update
    @course = Course.find(params[:id])

    respond_to do |format|
      if @course.update_attributes(params[:course])
        flash[:notice] = 'Course was successfully updated.'
        format.html { redirect_to(@course) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @course.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    errors = association_delete_error_messages(
    	[@course.template_classes_count, @course.klasses_count],
    	[t( 'courses.error.try_to_delete_course_with_template_classes' ),
    	 t( 'courses.error.try_to_delete_course_with_klasses' )])
	    	 
		if( !errors.empty? )
      flash[:error] = errors.join("<br />")
      redirect_to courses_path and return
    end

    @course.destroy
    redirect_to courses_path
  end
end
