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
end