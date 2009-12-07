require 'rubygems'
require 'activerecord'
require '../app/models/kanji.rb'
require '../app/models/glossary.rb'

ActiveRecord::Base.establish_connection(
  :adapter => 'mysql',
	:encoding => 'utf8',
  :host => '127.0.0.1',
  :database => 'yoyaku_development'
)

Glossary.delete_all

Kanji.all.each do |kanji|
	Glossary.create!( :japanese => kanji.japanese, :hiragana => kanji.katakana, :kanji => kanji.kanji, :english => kanji.english )
end