lass CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :title
      t.references :category
    end
  end
end
