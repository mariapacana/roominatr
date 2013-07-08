module UsersHelper
	def format_params(params)
		if params["birthday(1i)"]
			datestring = "#{params["birthday(1i)"]}-#{params["birthday(2i)"]}-#{params["birthday(3i)"]}"
			["birthday(1i)", "birthday(2i)", "birthday(3i)"].each do |birth|
				params.delete(birth) if params[birth]
			end
			params[:birthday] = Date.parse(datestring)
		end

		params
	end

	def create_category_scores(user)
		Category.all.each do |category|
			CategoryScore.create(user: user, category: category)
		end
	end
end