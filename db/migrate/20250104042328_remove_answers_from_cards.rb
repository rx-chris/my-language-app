class RemoveAnswersFromCards < ActiveRecord::Migration[8.0]
  def change
    remove_column :cards, :user_answer, :text
    remove_column :cards, :model_answer, :text
  end
end
