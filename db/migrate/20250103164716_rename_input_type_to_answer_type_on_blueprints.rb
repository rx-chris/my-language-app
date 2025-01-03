class RenameInputTypeToAnswerTypeOnBlueprints < ActiveRecord::Migration[8.0]
  def change
    rename_column :blueprints, :input_type, :answer_type
  end
end
