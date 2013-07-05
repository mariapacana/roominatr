class AddResponseidToChoices < ActiveRecord::Migration
  def change
    add_column :choices, :response_id, :integer
    add_column :responses, :choice_id, :integer
  end
end
