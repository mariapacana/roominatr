class AddHasHouseToUsers < ActiveRecord::Migration
  def change
    add_column :users, :has_house, :boolean
  end
end
