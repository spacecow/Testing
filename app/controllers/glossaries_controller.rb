# -*- coding: utf-8 -*-
class GlossariesController < ApplicationController
  load_and_authorize_resource

  def create
    if @glossary.save
      flash[:notice] = t('notice.create_success', :object=>t(:glossary).downcase)
      redirect_to new_glossary_path
    else
      render :new
    end
  end

  def quiz_init
    session[:glossaries] = Glossary.all #.shuffle
    glossary = session[:glossaries].shift
    kanjis = glossary.word.japanese
    kanjis.split(//).each do |kanji|
      words = Word.all(:conditions => ["japanese like (?)", "%#{kanji}%"] ).
        reject{|e| e.japanese == kanjis}
      words.each do |word|
        glossary.relations << word
      end
    end
    session[:glossary] = glossary
    redirect_to quiz_glossaries_path
  end

  def quiz
    glossary = session[:glossary]
    @question = glossary.question
    @correct_answer = glossary.answer
    @part_answer = params[:part_answer] || @correct_answer.gsub(/[^。、・]/,'＊')
  end

  def check
    glossary = session[:glossary]
    part_answer = update_answer(glossary.answer, params[:answer], params[:part_answer])
    if glossary.correct_answer?( part_answer )
      if glossary.next_question?
        glossary.next_question
      else
        session[:glossary] = session[:glossaries].shift
      end
      part_answer = glossary.answer.gsub(/[^。、・]/,'＊')
    end
    redirect_to quiz_glossaries_path( :part_answer => part_answer )
  end

  private

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
