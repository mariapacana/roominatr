class CategoryScore < ActiveRecord::Base
	belongs_to :user
	belongs_to :category

	def update(qtype, point)
		score = read_attribute(qtype.to_sym)
		score += point
		update_attribute(qtype.to_sym, score)
	end
end