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

  def index
    @glossaries = Glossary.all
  end

  def quiz_init
    session[:glossaries] = Glossary.all #.shuffle
    session[:glossary] = init_glossary( session[:glossaries].shift )
    redirect_to quiz_glossaries_path
  end

  def quiz
    glossary = session[:glossary]
    @question = glossary.question
    @correct_answer = glossary.answer
    @part_answer = params[:part_answer] || hide( @correct_answer )
  end

  def check
    glossary = session[:glossary]
    part_answer = update_answer(glossary.answer, params[:answer], params[:part_answer])
    if glossary.correct_answer?( part_answer )
      if glossary.next_question?
        glossary.next_question
      elsif !session[:glossaries].empty?
        glossary = session[:glossary]=init_glossary(session[:glossaries].shift)
      else
        redirect_to glossaries_path and return
      end
      part_answer = hide( glossary.answer )
    end
    redirect_to quiz_glossaries_path( :part_answer => part_answer )
  end

  private

    def update_answer( correct_answer, answer, part_answer )
      new_part_answer = correct_answer.gsub(/#{answer}/, answer.gsub(/./,'＊'))
      new_parts = new_part_answer.split(//)
      corrects = correct_answer.split(//)
      parts = part_answer.split(//)
      
      new_parts.each_with_index do |part,i|
        if part=="＊"
          parts[i] = corrects[i]
        end
      end

      parts.join
    end

    def hide( sentence )
      if (sentence =~ /[a-z]/).nil?
        sentence.gsub(/[^。、・]/,'＊')
      else
        sentence.gsub(/[^'., \/-]/,'*')
      end
    end
    
    def init_glossary( glossary )
      kanjis = glossary.word.japanese
      kanjis.split(//).each do |kanji|
        glossary_hits =
          Glossary.all(:conditions => ["words.japanese like (?)", "%#{kanji}%"],
                       :include => :word ).reject{|e| e == glossary}
        glossary_hits.each{|g| glossary.relations << g.word }
      end
      glossary
    end
end
