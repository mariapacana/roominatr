class CreateCategoryScores < ActiveRecord::Migration
	def change
		create_table :category_scores do |t|
			t.integer :me, :default => 0, :null => false
			t.integer :roommate, :default => 0, :null => false
			t.integer :importance, :default => 0, :null => false
			t.references :user
			t.references :category
		end
	end
end