class KanjisKunyomis < ActiveRecord::Base
	validates_presence_of :kanji, :kunyomi
	belongs_to :kanji
	belongs_to :kunyomi
end

# == Schema Information
#
# Table name: kanjis_kunyomis
#
#  kanji_id   :integer(4)
#  kunyomi_id :integer(4)
#

