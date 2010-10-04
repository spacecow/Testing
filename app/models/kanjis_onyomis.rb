class KanjisOnyomis < ActiveRecord::Base
	validates_presence_of :kanji, :onyomi
	belongs_to :kanji
	belongs_to :onyomi
end

# == Schema Information
#
# Table name: kanjis_onyomis
#
#  kanji_id  :integer(4)
#  onyomi_id :integer(4)
#

