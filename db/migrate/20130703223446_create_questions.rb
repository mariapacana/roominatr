class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :body
      t.string :type
      t.references :survey
    end 
  end
end
