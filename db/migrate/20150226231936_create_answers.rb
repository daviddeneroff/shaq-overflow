class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :question_id, null: false
      t.integer :user_id, null: false
      t.text :content, null: false
      t.boolean :accepted, default: false

      t.timestamps null: false
    end
  end
end
