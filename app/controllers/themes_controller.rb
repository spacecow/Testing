class ThemesController < ApplicationController
  load_and_authorize_resource

  def index
    @themes = Theme.all
  end

  def create
    if @theme.save
      flash[:notice] = t('notice.create_success', :object=>t(:theme).downcase)
      redirect_to themes_path
    else
      render :new
    end
  end

  def show
    @glossaries = Glossary.find_all_by_theme_id(params[:id])
  end
end
