module ScoreHelper
	def update_category_score(user, category)
		@user = user
		@category = category
		return if submission.survey.category == @category
		@user.responses.each	do |submission|
			@response = response
			if response.question.me?
				increment_me
			elsif response.question.roommate?
				increment_roommate
			else
				increment_importance
			end
		end
		calculate_and_update_scores
	end

	def increment_me
		@me_total ||= 0
		@me_total += 1
		@me_count += @response.answer.weight
	end

	def increment_roommate
		@roommate_total ||= 0
		@roommate_total += 1
		@roommate_count += @response.answer.weight
	end

	def increment_importance
		@importance_total ||= 0
		@importance_total += 1
		@importance_count += @response.answer.weight
	end

	def me_total
		@me_total.zero? ? 0.0 : @me_count/@me_total.to_f
	end

	def roommate_total
		@roommate_total.zero? ? 0.0 : @roommate_count/@roommate_total.to_f
	end

	def importance_total
		@roommate_total.zero? ? 0.0 : @roommate_count/@roommate_total.to_f
	end

	def calculate_and_update_scores
		category_score = CategoryScore.find_by_user_id_and_category_id(@user.id, @category.id)
		category_score.update_attributes(:me => me_total, :roommate => roommate_total, :importance => importance_total)
	end
end
