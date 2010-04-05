class WordsController < ApplicationController
  def index
    @words = Word.all
  end
  
  def show
    @word = Word.find(params[:id])
  end
  
  def new
    @word = Word.new
  end
  
  def create
    @word = Word.new(params[:word])
    if @word.save
      flash[:notice] = "Successfully created word."
      redirect_to @word
    else
      render :action => 'new'
    end
  end
  
  def edit
    @word = Word.find(params[:id])
  end
  
  def update
    @word = Word.find(params[:id])
    if @word.update_attributes(params[:word])
      flash[:notice] = "Successfully updated word."
      redirect_to @word
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @word = Word.find(params[:id])
    @word.destroy
    flash[:notice] = "Successfully destroyed word."
    redirect_to words_url
  end
end
