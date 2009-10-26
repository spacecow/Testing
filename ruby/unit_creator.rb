require 'rubygems'
require 'activerecord'
require '../app/models/course.rb'
require '../app/models/unit.rb'
require '../app/models/schedule.rb'
filename = "Shokyuu Units.txt"

ActiveRecord::Base.establish_connection(
  :adapter => 'mysql',
	:encoding => 'utf8',
  :host => '127.0.0.1',
  :database => 'yoyaku_development'
)

Unit.delete_all
Schedule.delete_all

titles = [ :unit, :title, :page, :description ]

course = Course.find_by_name( "初級 I" )
schedule = Schedule.create!( :course_id => course.id )
#schedule_id = Schedule.find_by_title( "初級 I" ).id

File.open filename, 'r' do |f|
	f.readlines.each do |line|
	  while line.match(/"(.+),(.+)"/)
      line = line.gsub(/"(.+),(.+)"/, "\""+$1+"#"+$2+"\"")
    end
		array = titles.zip( line.split(',')) + [ :schedule_id, schedule.id ]
    hash = Hash[ *array.flatten ]
    title = hash[:title]
	  while title.match(/"(.+)#(.+)"/)
      title = title.gsub(/"(.+)#(.+)"/, "\""+$1+","+$2+"\"")
    end
    title = title.gsub(/"(.+)"/, $1) if title.match(/"(.+)"/)
    hash[:title] = title
		Unit.new( hash ).save
	end
end
