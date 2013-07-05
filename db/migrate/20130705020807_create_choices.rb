class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
        t.references :answer
        t.references :user
        t.timestamps 
      end     
  end
end
