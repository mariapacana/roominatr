class ScoreWorker
	include Sidekiq::Worker
	include ScoreHelper

	def perform(user_id, category_id)
		user = User.find(user_id)
		category = Category.find(category_id)
		update_category_score(user, category)
	end
end