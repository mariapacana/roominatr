class AddSummaryToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :summary, :text
  	add_column :users, :best_roommate, :text
  	add_column :users, :worst_roommate, :text
  	add_column :users, :pets, :string
  	add_column :users, :food_preferences, :string
  	add_column :users, :weekend_activity, :string
    add_column :users, :rent_pref_min, :integer
    add_column :users, :rent_pref_max, :integer
  end
end