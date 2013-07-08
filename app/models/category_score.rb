class CategoryScore < ActiveRecord::Base
	belongs_to :user
	belongs_to :category
	attr_accessible :me, :roommate, :importance

	def update_score(qtype, point)
		score = read_attribute(qtype.to_sym)
		score += point
		update_attribute(qtype.to_sym, score)
	end
end