class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.string :text
      t.string :answer
      t.belongs_to :user

      t.timestamps null: false
    end
  end
end
