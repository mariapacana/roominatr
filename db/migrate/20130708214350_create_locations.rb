class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.float :lat
      t.float :long
      t.string :address
      t.string :neighborhood
      t.string :city
      t.string :state   
      t.string :country     
      t.string :zip
      t.integer :addressable_id
      t.string :addressable_type
    end
  end
end
