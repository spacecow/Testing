module ApplicationHelper
	def toggle_div( div, link, link2 )
		update_page do |page|
			page.visual_effect :toggle_appear, div
			page[link].toggle
			page[link2].toggle
		end
	end
end
