# -*- coding: utf-8 -*-
class Kanji < ActiveRecord::Base
  has_and_belongs_to_many :meanings
  has_and_belongs_to_many :onyomis
  has_and_belongs_to_many :kunyomis
  validates_presence_of :title

  def self.generate_default_models
    generate_models( "data/kanjidic.utf" )
  end

  def second_answer(state); meanings.map(&:title).join(', ') end
  def second_question(question); highlight( question, title ) end
  
  private

    def highlight( text, word )
      text.gsub(word, "<font color=\"red\">#{word}</font>")
    end
  
  def self.onyomi?( word )
    word =~ /ァ/ || word =~ /ア/ || word =~ /ィ/ || word =~ /イ/ || word =~ /ゥ/ || word =~ /ウ/ || word =~ /ェ/ || word =~ /エ/ || word =~ /ォ/ || word =~ /オ/ || word =~ /カ/ || word =~ /ガ/ || word =~ /キ/ || word =~ /ギ/ || word =~ /ク/ ||
      word =~ / / || word =~ /グ/ || word =~ /ケ/ || word =~ /ゲ/ || word =~ /コ/ || word =~ /ゴ/ || word =~ /サ/ || word =~ /ザ/ || word =~ /シ/ || word =~ /ジ/ || word =~ /ス/ || word =~ /ズ/ || word =~ /セ/ || word =~ /ゼ/ || word =~ /ソ/ || word =~ /ゾ/ || word =~ /タ/ ||
      word =~ / / || word =~ /ダ/ || word =~ /チ/ || word =~ /ヂ/ || word =~ /ッ/ || word =~ /ツ/ || word =~ /ヅ/ || word =~ /テ/ || word =~ /デ/ || word =~ /ト/ || word =~ /ド/ || word =~ /ナ/ || word =~ /ニ/ || word =~ /ヌ/ || word =~ /ネ/ || word =~ /ノ/ || word =~ /ハ/ ||
      word =~ / / || word =~ /バ/ || word =~ /パ/ || word =~ /ヒ/ || word =~ /ビ/ || word =~ /ピ/ || word =~ /フ/ || word =~ /ブ/ || word =~ /プ/ || word =~ /ヘ/ || word =~ /ベ/ || word =~ /ペ/ || word =~ /ホ/ || word =~ /ボ/ || word =~ /ポ/ || word =~ /マ/ || word =~ /ミ/ ||
      word =~ / / || word =~ /ム/ || word =~ /メ/ || word =~ /モ/ || word =~ /ャ/ || word =~ /ヤ/ || word =~ /ュ/ || word =~ /ユ/ || word =~ /ョ/ || word =~ /ヨ/ || word =~ /ラ/ || word =~ /リ/ || word =~ /ル/ || word =~ /レ/ || word =~ /ロ/ || word =~ /ヮ/ || word =~ /ワ/ ||
      word =~ / / || word =~ /ヰ/ || word =~ /ヱ/ || word =~ /ヲ/ || word =~ /ン/ || word =~ /ヴ/ || word =~ /ヵ/ || word =~ /ヶ/ || word =~ /ヷ/ || word =~ /ヸ/ || word =~ /ヹ/ || word =~ /ヺ/ || word =~ /・/ || word =~ /ー/ || word =~ /ヽ/ || word =~ /ヾ/
  end

  def self.nanori?( word )
    word == "T1"
  end

  def self.kunyomi?( word )
    word =~ /ぁ/ || word =~ /あ/ || word =~ /ぃ/ || word =~ /い/ || word =~ /ぅ/ || word =~ /う/ || word =~ /ぇ/ || word =~ /え/ || word =~ /ぉ/ || word =~ /お/ || word =~ /か/ || word =~ /が/ || word =~ /き/ || word =~ /ぎ/ || word =~ /く/ ||
      word =~ /ぐ/ || word =~ /け/ || word =~ /げ/ || word =~ /こ/ || word =~ /ご/ || word =~ /さ/ || word =~ /ざ/ || word =~ /し/ || word =~ /じ/ || word =~ /す/ || word =~ /ず/ || word =~ /せ/ || word =~ /ぜ/ || word =~ /そ/ || word =~ /ぞ/ || word =~ /た/ ||
      word =~ /だ/ || word =~ /ち/ || word =~ /ぢ/ || word =~ /っ/ || word =~ /つ/ || word =~ /づ/ || word =~ /て/ || word =~ /で/ || word =~ /と/ || word =~ /ど/ || word =~ /な/ || word =~ /に/ || word =~ /ぬ/ || word =~ /ね/ || word =~ /の/ || word =~ /は/ ||
      word =~ /ば/ || word =~ /ぱ/ || word =~ /ひ/ || word =~ /び/ || word =~ /ぴ/ || word =~ /ふ/ || word =~ /ぶ/ || word =~ /ぷ/ || word =~ /へ/ || word =~ /べ/ || word =~ /ぺ/ || word =~ /ほ/ || word =~ /ぼ/ || word =~ /ぽ/ || word =~ /ま/ || word =~ /み/ ||
      word =~ /む/ || word =~ /め/ || word =~ /も/ || word =~ /ゃ/ || word =~ /や/ || word =~ /ゅ/ || word =~ /ゆ/ || word =~ /ょ/ || word =~ /よ/ || word =~ /ら/ || word =~ /り/ || word =~ /る/ || word =~ /れ/ || word =~ /ろ/ || word =~ /ゎ/ || word =~ /わ/ ||
      word =~ /ゐ/ || word =~ /ゑ/ || word =~ /を/ || word =~ /ん/ || word =~ /ゔ/ || word =~ /゛/ || word =~ /゜/ || word =~ /ゝ/ || word =~ /ゞ/
  end

  def self.meaning?(word)
    word =~ /[{].+[}]/
  end

  def self.generate_models( file )
    Kanji.delete_all
    File.open file, 'r' do |infile|
      infile.readlines.each_with_index do |line,i|
        p i if i%1000 == 0
        info = line.split
        kanji = Kanji.create!( :title => info[0] )
        nanori = false
        info.each do |word|
          if onyomi?( word )
            onyomi = Onyomi.find_by_reading( word ) || Onyomi.create!( :reading => word )
            kanji.onyomis << onyomi
          elsif nanori?( word )
            nanori = true
          elsif !nanori && kunyomi?( word )
            kunyomi = Kunyomi.find_by_reading( word ) || Kunyomi.create!( :reading => word )
            kanji.kunyomis << kunyomi
          elsif meaning?( word )
            word =~ /[{](.+)[}]/
            meaning = Meaning.find_by_title( $1 ) || Meaning.create!( :title => $1 )
            kanji.meanings << meaning
          end
        end
      end
    end
  end
end

# == Schema Information
#
# Table name: kanjis
#
#  id         :integer(4)      not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  title      :string(255)
#

