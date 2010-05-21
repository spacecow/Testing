class TeachingsController < ApplicationController
	before_filter :find_multiple_users, :only => [:edit_multiple, :update_multiple]
	load_and_authorize_resource

  def edit
  end
  
  def update
		if @teaching.update_attributes( params[:teaching] )
			redirect_to salary_users_path
		else
			render :edit
		end
	end
	
	def edit_multiple
		if @teachings.nil?
			flash[:error] = "Select at least one teaching in order to multi edit."
			redirect_to salary_users_path( :salary_month => params[:salary_month_backtrack] )
		end
	end
	
	def update_multiple
		@teachings.each do |teaching|
			teaching.update_attributes!( params[:teaching].reject{|k,v| v.blank? } )
		end
		flash[:notice] = "No changes." if params[:teaching][:cost].blank?
		redirect_to salary_users_path( :salary_month => @teachings[0].klass.date.month )
	end	

private

  def find_multiple_users
    @teachings = Teaching.find( params[:teaching_ids] ) unless params[:teaching_ids].nil?
  end

end
