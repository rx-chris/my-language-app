class AddContentTypeToBlueprints < ActiveRecord::Migration[8.0]
  def change
    add_column :blueprints, :content_type, :integer, null: false, default: 0
  end
end
