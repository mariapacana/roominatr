module ScoreHelper

	def update_category_score(user, category)
		score_table = CategoryScore.find_by_user_id_and_category_id(user.id, category.id)
		me_count = 0
		me_total = 0
		roommate_count = 0
		roommate_total = 0
		importance_count = 0
		importance_total = 0
		user.submissions.each	do |submission|
			if submission.survey.category == category
				submission.responses.each do |response|
					if response.question.qtype == "me"
						me_total +=1
						me_count += response.answer.weight
					elsif response.question.qtype == "roommate"
						roommate_total += 1
						roommate_count += response.answer.weight
					else
						importance_total += 1
						importance_count += response.answer.weight
					end
				end
			end
		end

		me = me_count/me_total.to_f
		me = me.nan? ? 0.0 : me
		roommate = roommate_count/roommate_total.to_f
		roommate = roommate.nan? ? 0.0 : roommate
		importance = importance_count/importance_total.to_f
		importance = importance.nan? ? 0.0 : importance

		score_table.update_attribute(:me, me)
		score_table.update_attribute(:roommate, roommate)
		score_table.update_attribute(:importance, importance) 
		score_table
	end
end
