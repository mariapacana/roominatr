class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.float :lat
      t.float :long
      t.string :address
      t.string :neighborhood
      t.references :user
    end
  end
end