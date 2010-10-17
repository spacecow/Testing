class Glossary < ActiveRecord::Base
  belongs_to :word
  belongs_to :theme
  
  attr_accessible :japanese, :english, :kanji, :hiragana, :state, :theme_id
  attr_accessor :kanji, :hiragana
  validates_presence_of :japanese, :word_id, :theme_id
  validates_uniqueness_of :japanese

  before_validation :find_word

  def index; @index || 1 end
  
  def kanji_no; word.kanji_no end
  
  def answer
    case state
    when 0: japanese
    when 1: word.meaning.gsub(/\(.+?\)/,"")
    when 2: word.reading
    else relations[state-3].second_answer(state)
    end
  end

  def correct_answer?( part_answer ); part_answer == answer end

  def next_question; self.state += 1 end
  def next_question?; state < relations.size + 2 end

  def highlight( text, word )
    text.gsub(word, "<font color=\"red\">#{word}</font>")
  end
  
  def question
    case state
    when 0: english
    when 1: highlight( japanese, word.japanese )
    when 2: highlight( japanese, word.japanese )
    else relations[state-3].second_question(japanese)
    end
  end

  def relations; @relations ||= [] end

  def second_answer(index)
    @index ||= index
    @index == index ? word.reading : word.meaning 
  end

  def second_question( question )
    highlight( japanese, word.japanese )
  end
  
  def state; @state ||= 0 end
  def state=( no ); @state = no end

  private

    def find_word
      word = Word.find_by_japanese_and_reading( kanji, hiragana )
      self.word_id = word.id unless word.nil?
    end
end


# == Schema Information
#
# Table name: glossaries
#
#  id         :integer(4)      not null, primary key
#  japanese   :string(255)
#  english    :string(255)
#  created_at :datetime
#  updated_at :datetime
#  state      :integer(4)      default(0)
#  word_id    :integer(4)
#

