class Glossary < ActiveRecord::Base
  belongs_to :word
  
  attr_accessible :japanese, :english, :kanji, :hiragana, :state
  attr_accessor :kanji, :hiragana
  validates_presence_of :japanese, :word_id
  validates_uniqueness_of :japanese

  before_validation :find_word

  def state
    @state ||= 0
  end

  def relations
    @relations ||= []
  end
  
  def state=( no )
    @state = no
  end
  
  def question
    case state
    when 0: english
    when 1: word.japanese
    else relations[state-2].japanese
    end
  end

  def answer
    case state
    when 0: japanese
    when 1: word.reading
    else relations[state-2].reading
    end
  end

  def correct_answer?( part_answer )
    part_answer == answer
  end

  def next_question?
    state < relations.size + 1
  end

  def next_question
    self.state += 1
  end

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

