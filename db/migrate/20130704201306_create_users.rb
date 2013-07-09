class CreateUsers < ActiveRecord::Migration
	def change
		create_table :users do |t|
			t.string :username
			t.string :gender
			t.date :birthday
			t.text :photo
      t.references :addressable, :polymorphic => true
			t.timestamps
		end
	end
end
