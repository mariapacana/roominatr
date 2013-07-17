module ApplicationHelper
	def random_birthday
		age = rand(18..80)
		year = DateTime.now.year - age
		month = rand(1..12)
		day = rand(1..28)
		Date.new(year, month, day)
	end
end
