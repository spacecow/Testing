class KanjisOnyomis < ActiveRecord::Base
	validates_presence_of :kanji, :onyomi
	belongs_to :kanji
	belongs_to :onyomi
end
