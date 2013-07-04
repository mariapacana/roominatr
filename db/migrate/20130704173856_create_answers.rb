class CreateAnswers < ActiveRecord::Migration
	def change
		create_table :answers do |t|
			t.string :text
			t.integer :weight
			t.references :question
			t.timestamps
		end
	end
end
