class AddSummaryToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :summary, :text
  	add_column :users, :best_roomate, :text
  	add_column :users, :worst_roomate, :text
  	add_column :users, :pets, :string
  	add_column :users, :food_preferences, :string
  	add_column :users, :weekend_activity, :string
  end
end