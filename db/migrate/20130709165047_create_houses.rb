class CreateHouses < ActiveRecord::Migration
  def change
    create_table :houses do |t|
      t.text :description
      t.text :image
      t.integer :num_beds
      t.integer :rent
      t.boolean :dog
      t.boolean :cat
      t.boolean :smoking
    end
  end
end
