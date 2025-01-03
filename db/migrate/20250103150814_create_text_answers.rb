class CreateTextAnswers < ActiveRecord::Migration[8.0]
  def change
    create_table :text_answers do |t|
      t.text :user_answer
      t.text :model_answer, null: false
      t.references :card, null: false, foreign_key: true

      t.timestamps
    end
  end
end
