class CreateCards < ActiveRecord::Migration[8.0]
  def change
    create_table :cards do |t|
      t.text :instruction, null: false
      t.text :text_content
      t.text :user_answer
      t.text :model_answer, null: false
      t.references :lesson, null: false, foreign_key: true
      t.references :blueprint, null: false, foreign_key: true
      t.boolean :correct
      t.boolean :bookmarked, null: false, default: false

      t.timestamps
    end
  end
end
