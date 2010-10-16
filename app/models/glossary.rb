class Glossary < ActiveRecord::Base
  belongs_to :word
  
  attr_accessible :japanese, :english, :kanji, :hiragana, :state, :theme_id
  attr_accessor :kanji, :hiragana
  validates_presence_of :japanese, :word_id, :theme_id
  validates_uniqueness_of :japanese

  before_validation :find_word

  def answer
    case state
    when 0: japanese
    when 1: word.meaning.gsub(/\(.+?\)/,"")
    when 2: word.reading
    else state%2==0 ? relations[(state-3)/2].word.reading : relations[(state-3)/2].word.meaning.gsub(/\(.+?\)/,"")
    end
  end

  def correct_answer?( part_answer ); part_answer == answer end

  def next_question; self.state += 1 end
  def next_question?; state < relations.size*2 + 2 end

  def highlight( text, word )
    text.gsub(word, "<font color=\"red\">#{word}</font>")
  end
  
  def question
    case state
    when 0: english
    when 1: highlight( japanese, word.japanese )
    when 2: highlight( japanese, word.japanese )
    else highlight( relations[(state-3)/2].japanese, relations[(state-3)/2].word.japanese)
    end
  end

  def relations; @relations ||= [] end

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

