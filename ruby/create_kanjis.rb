require 'jcode'
require 'rubygems'
require 'activerecord'
require '../app/models/kanji.rb'
require '../app/models/onyomi.rb'
require '../app/models/kunyomi.rb'
require '../app/models/meaning.rb'

$KCODE = "UTF-8"
filename = '..\data\kanjidic.txt'

ActiveRecord::Base.establish_connection(
  :adapter => 'mysql',
	:encoding => 'utf8',
  :host => '127.0.0.1',
  :database => 'yoyaku_development'
)

Kanji.delete_all
Onyomi.delete_all
Kunyomi.delete_all
Meaning.delete_all

katakana = "ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴヵヶヷヸヹヺ・ーヽヾ"

#katakana.length.times do |i|
#	p katakana[i]
#end


def onyomi?( word )
	word =~ /ァ/ || word =~ /ア/ || word =~ /ィ/ || word =~ /イ/ || word =~ /ゥ/ || word =~ /ウ/ || word =~ /ェ/ || word =~ /エ/ || word =~ /ォ/ || word =~ /オ/ || word =~ /カ/ || word =~ /ガ/ || word =~ /キ/ || word =~ /ギ/ || word =~ /ク/ ||
	word =~ / / || word =~ /グ/ || word =~ /ケ/ || word =~ /ゲ/ || word =~ /コ/ || word =~ /ゴ/ || word =~ /サ/ || word =~ /ザ/ || word =~ /シ/ || word =~ /ジ/ || word =~ /ス/ || word =~ /ズ/ || word =~ /セ/ || word =~ /ゼ/ || word =~ /ソ/ || word =~ /ゾ/ || word =~ /タ/ ||
	word =~ / / || word =~ /ダ/ || word =~ /チ/ || word =~ /ヂ/ || word =~ /ッ/ || word =~ /ツ/ || word =~ /ヅ/ || word =~ /テ/ || word =~ /デ/ || word =~ /ト/ || word =~ /ド/ || word =~ /ナ/ || word =~ /ニ/ || word =~ /ヌ/ || word =~ /ネ/ || word =~ /ノ/ || word =~ /ハ/ ||
	word =~ / / || word =~ /バ/ || word =~ /パ/ || word =~ /ヒ/ || word =~ /ビ/ || word =~ /ピ/ || word =~ /フ/ || word =~ /ブ/ || word =~ /プ/ || word =~ /ヘ/ || word =~ /ベ/ || word =~ /ペ/ || word =~ /ホ/ || word =~ /ボ/ || word =~ /ポ/ || word =~ /マ/ || word =~ /ミ/ ||
	word =~ / / || word =~ /ム/ || word =~ /メ/ || word =~ /モ/ || word =~ /ャ/ || word =~ /ヤ/ || word =~ /ュ/ || word =~ /ユ/ || word =~ /ョ/ || word =~ /ヨ/ || word =~ /ラ/ || word =~ /リ/ || word =~ /ル/ || word =~ /レ/ || word =~ /ロ/ || word =~ /ヮ/ || word =~ /ワ/ ||
	word =~ / / || word =~ /ヰ/ || word =~ /ヱ/ || word =~ /ヲ/ || word =~ /ン/ || word =~ /ヴ/ || word =~ /ヵ/ || word =~ /ヶ/ || word =~ /ヷ/ || word =~ /ヸ/ || word =~ /ヹ/ || word =~ /ヺ/ || word =~ /・/ || word =~ /ー/ || word =~ /ヽ/ || word =~ /ヾ/
end
def nanori?( word )
	word == "T1"
end
def kunyomi?( word )
	word =~ /ぁ/ || word =~ /あ/ || word =~ /ぃ/ || word =~ /い/ || word =~ /ぅ/ || word =~ /う/ || word =~ /ぇ/ || word =~ /え/ || word =~ /ぉ/ || word =~ /お/ || word =~ /か/ || word =~ /が/ || word =~ /き/ || word =~ /ぎ/ || word =~ /く/ ||
	word =~ /ぐ/ || word =~ /け/ || word =~ /げ/ || word =~ /こ/ || word =~ /ご/ || word =~ /さ/ || word =~ /ざ/ || word =~ /し/ || word =~ /じ/ || word =~ /す/ || word =~ /ず/ || word =~ /せ/ || word =~ /ぜ/ || word =~ /そ/ || word =~ /ぞ/ || word =~ /た/ ||
	word =~ /だ/ || word =~ /ち/ || word =~ /ぢ/ || word =~ /っ/ || word =~ /つ/ || word =~ /づ/ || word =~ /て/ || word =~ /で/ || word =~ /と/ || word =~ /ど/ || word =~ /な/ || word =~ /に/ || word =~ /ぬ/ || word =~ /ね/ || word =~ /の/ || word =~ /は/ ||
	word =~ /ば/ || word =~ /ぱ/ || word =~ /ひ/ || word =~ /び/ || word =~ /ぴ/ || word =~ /ふ/ || word =~ /ぶ/ || word =~ /ぷ/ || word =~ /へ/ || word =~ /べ/ || word =~ /ぺ/ || word =~ /ほ/ || word =~ /ぼ/ || word =~ /ぽ/ || word =~ /ま/ || word =~ /み/ ||
	word =~ /む/ || word =~ /め/ || word =~ /も/ || word =~ /ゃ/ || word =~ /や/ || word =~ /ゅ/ || word =~ /ゆ/ || word =~ /ょ/ || word =~ /よ/ || word =~ /ら/ || word =~ /り/ || word =~ /る/ || word =~ /れ/ || word =~ /ろ/ || word =~ /ゎ/ || word =~ /わ/ ||
	word =~ /ゐ/ || word =~ /ゑ/ || word =~ /を/ || word =~ /ん/ || word =~ /ゔ/ || word =~ /゛/ || word =~ /゜/ || word =~ /ゝ/ || word =~ /ゞ/
end
def meaning?(word)
	word =~ /[{].+[}]/
end

File.open filename, 'r' do |f|
	f.readlines.each_with_index do |line, i|
		p i
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

p Onyomi.count
p Kunyomi.count
p Meaning.count

