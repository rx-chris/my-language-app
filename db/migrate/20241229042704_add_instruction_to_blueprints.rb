class AddInstructionToBlueprints < ActiveRecord::Migration[8.0]
  def change
    add_column :blueprints, :instruction, :text, null: false, default: 'Enter instructions here'
    change_column_default :blueprints, :instruction, from: 'Enter instructions here', to: nil
  end
end
