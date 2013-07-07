class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.references :survey
      t.references :user
      t.timestamps
    end
    add_index :submissions, [:survey_id, :user_id], :unique => true
  end
end
