class RemoveContextFromCurricula < ActiveRecord::Migration[8.0]
  def change
    remove_column :curricula, :context, :text
  end
end
