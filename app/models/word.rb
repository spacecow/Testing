class Word < ActiveRecord::Base
  attr_accessible :japanese, :reading, :meaning

	def self.generate_default_csv
		generate_csv( "data/edict.utf" )
	end
  
  def self.generate_csv( file )
  	Word.delete_all
  	File.open file.gsub(/utf/,'csv'), 'w' do |outfile|
	  	File.open file, 'r' do |infile|
				infile.readlines.each_with_index do |line,i|
					p i if i%1000 == 0
					line =~ /(.+?)\/(.+)/
					japanese_reading = $1;
					meaning = "/"+$2
					japanese_reading =~ /(.+?) (?:\[(.+)\] )?/
					outfile.write("#{i+1}@#{$1}@#{$2}@#{meaning[0..250]}\n")
					#Word.create!(:japanese=>$1, :reading=>$2, :meaning=>meaning)
				end
			end
		end
  end
end
