class Word < ActiveRecord::Base
  has_many :glossaries

  attr_accessible :japanese, :reading, :meaning

  def self.generate_default_csv
    generate_csv( "data/edict.utf" )
  end

  private

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
# == Schema Information
#
# Table name: words
#
#  id       :integer(4)      not null, primary key
#  japanese :string(255)
#  reading  :string(255)
#  meaning  :string(255)
#

