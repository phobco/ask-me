class CreateQuestionHashtags < ActiveRecord::Migration[6.1]
  def change
    create_table :question_hashtags do |t|
      t.references :question, null: false, foreign_key: true
      t.references :hashtag, null: false, foreign_key: true

      t.timestamps
    end

    add_index :question_hashtags, %i[question_id hashtag_id], unique: true
  end
end
