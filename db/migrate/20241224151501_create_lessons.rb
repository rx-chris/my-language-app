class CreateLessons < ActiveRecord::Migration[8.0]
  def change
    create_table :lessons do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.integer :order, null: false
      t.references :curriculum, null: false, foreign_key: true

      t.timestamps
    end
  end
end
