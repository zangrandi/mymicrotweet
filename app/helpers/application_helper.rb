module ApplicationHelper
	def parse_text(text)
		parsed_text = text.gsub(/\@(\w)*/) do 
			mention = $&
			link = mention.gsub("@","")
			link_to "#{mention}", "/#{link}"
		end
		h auto_link(parsed_text)
	end
end
