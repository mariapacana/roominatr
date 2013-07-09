class CreateCategoryScores < ActiveRecord::Migration
	def change
		create_table :category_scores do |t|
			t.float :me, :default => 0, :null => false
			t.float :roommate, :default => 0, :null => false
			t.float :importance, :default => 0, :null => false
			t.references :user
			t.references :category
		end
	end
end