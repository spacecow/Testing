# -*- coding: utf-8 -*-
class GlossariesController < ApplicationController
  load_and_authorize_resource

  def new
    @glossary = Glossary.new(:theme_id => params[:theme_id])
  end
  
  def create
    if @glossary.save
      flash[:notice] = t('notice.create_success', :object=>t(:glossary).downcase)
      redirect_to new_glossary_path(:theme_id => @glossary.theme_id)
    else
      render :new
    end
  end

  def index
    @glossaries = Glossary.all
  end

  def update
    if @glossary.update_attributes( params[:glossary] )
      redirect_to glossaries_path
    else
      render :edit
    end
  end
  
  def quiz_init
    if params[:theme_id].nil?
      session[:glossaries] = Glossary.all.sort_by{ rand }
    else
      session[:glossaries] = Glossary.find_all_by_theme_id(params[:theme_id].to_i).sort_by{ rand }
    end
    session[:glossary] = init_glossary( session[:glossaries].shift )
    session[:glossary].state = params[:state].to_i
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
    
    def init_glossary(glossary)
      chars = glossary.japanese.split(//)
      length = chars.length
      length.times do |j|
        (length-j).times do |i|
          word_s = chars[j..length-i-1].join
          if word_s.length == 3
            kanji = Kanji.find_by_title(word_s)
            unless kanji.nil?
              glossary.add_question(kanji)
              glossary_hits =
                Glossary.all(
                  :conditions => ["words.japanese like (?)", "%#{kanji.title}%"],
                  :include => :word ).reject{|e| e == glossary}
              glossary_hits.each do |g|
                glossary.add_question(g.word,g.japanese)
                glossary.add_question(g.word,g.japanese)
              end
            end
          else
            word = Word.find_by_japanese(word_s)
            unless word.nil?
              glossary.add_question(word)
              glossary.add_question(word)
            end
          end
        end
      end
      glossary
    end
    
    def init_glossary_old( glossary )
      kanjis = glossary.word.japanese
      kanjis.split(//).each do |kanji|       
        next unless is_kanji?(kanji)
        glossary.relations << Kanji.find_by_title(kanji)
        glossary_hits =
          Glossary.all(:conditions => ["words.japanese like (?)", "%#{kanji}%"],
                       :include => :word ).reject{|e| e == glossary}
        glossary_hits.each do |g|
          glossary.relations << g
          glossary.relations << g
        end
      end
      glossary
    end

    def is_kanji?(kanji)
      !('あ'..'ん').to_a.include?(kanji)
    end
end
