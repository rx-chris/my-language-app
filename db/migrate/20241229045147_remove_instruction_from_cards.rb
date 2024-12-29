class RemoveInstructionFromCards < ActiveRecord::Migration[8.0]
  def change
    remove_column :cards, :instruction, :text
  end
end
