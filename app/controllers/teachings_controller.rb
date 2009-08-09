class TeachingsController < ApplicationController
  def edit
  	@teaching = Teaching.find( params[:id] )
  end
  def update
		@teaching = Teaching.find( params[:id] )
		if @teaching.update_attributes( params[:teaching] )
			redirect_to edit_courses_teacher_path( @teaching.teacher_id )
		end
	end
end
