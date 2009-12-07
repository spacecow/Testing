class Glossary < ActiveRecord::Base
  attr_accessible :japanese, :hiragana, :kanji, :english
  validates_presence_of :japanese, :hiragana, :kanji
  validates_uniqueness_of :japanese
end
