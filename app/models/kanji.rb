class Kanji < ActiveRecord::Base
  attr_accessible :japanese, :katakana, :kanji, :english
  validates_presence_of :japanese, :katakana, :kanji
end
