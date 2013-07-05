class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.references :submission
      t.references :answer
      t.references :question
      t.timestamps
    end
  end
end
