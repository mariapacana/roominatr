class ScoreWorker
	include Sidekiq::Worker
	include ScoreHelper

	def perform(user, category)
		update_category_score(user, category)
	end
end