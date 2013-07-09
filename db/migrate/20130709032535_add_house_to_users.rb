class AddHouseToUsers < ActiveRecord::Migration
  def change
    add_column :users, :house, :boolean
  end
end
