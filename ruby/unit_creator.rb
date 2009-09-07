require 'rubygems'
require 'activerecord'
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

Schedule.new( :title => "初級 I" ).save
schedule_id = Schedule.find_by_title( "初級 I" ).id

File.open filename, 'r' do |f|
	f.readlines.each do |line|
		array = titles.zip( line.split(',')) + [ :schedule_id, schedule_id ]
		Unit.new( Hash[ *array.flatten ]).save
	end
end
