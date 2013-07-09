class CreateHouses < ActiveRecord::Migration
  def change
    create_table :houses do |t|
      t.text :description
      t.text :house_type
      t.integer :num_beds
      t.integer :num_baths
      t.integer :rent
      t.integer :deposit
      t.boolean :dog
      t.boolean :cat
      t.boolean :smoking
      t.boolean :background_check
      t.references :user
    end
  end
end
