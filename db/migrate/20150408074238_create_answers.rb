class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :word_id
      t.string :name
      t.integer :correct

      t.timestamps null: false
    end
  end
end
