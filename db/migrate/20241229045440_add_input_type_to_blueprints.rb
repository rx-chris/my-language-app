class AddInputTypeToBlueprints < ActiveRecord::Migration[8.0]
  def change
    add_column :blueprints, :input_type, :integer, null: false, default: 0
  end
end
