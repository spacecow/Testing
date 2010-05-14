class CoursesController < ApplicationController
  load_and_authorize_resource
  
  def index
    @sorting = Sorting.new
  	@courses_groups = Course.all( :select=>"name, id, klasses_count, template_classes_count" ).group_by(&:category)
		@keys = @sorting.sort_in_mogi_order( @courses_groups.keys )
  end

  def show
    #@course = Course.find(params[:id], :include=>[ :klasses, :template_classes ])
  	#@sorting = Sorting.new
    #@template_klass_groups = @course.template_classes.group_by( &:day )
    #@keys = @sorting.sort_by_day @template_klass_groups.keys    
	end

  def new
  end

  def edit
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

  def update
    if @course.update_attributes(params[:course])
      flash[:notice] = t('notice.update_success', :object => t(:course))
      redirect_to @course
    else
      render :action => "edit"
    end
  end

  def destroy
    errors = association_delete_error_messages(
    	[@course.template_classes_count, @course.klasses_count],
    	[t( 'courses.error.try_to_delete_course_with_template_classes' ),
    	 t( 'courses.error.try_to_delete_course_with_klasses' )])
	    	 
		if( !errors.empty? )
      flash[:error] = errors.join("<br />")
      redirect_to :back and return
    end

    @course.destroy
    redirect_to courses_path
  end
end
