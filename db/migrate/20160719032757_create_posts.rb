class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.integer :answer_id
      t.string  :title
      t.string  :content
      t.integer :vote_count, default: 0
      t.integer :comment_count, default: 0
      t.integer :collection_count, default: 0
      t.integer :position
      t.string  :status

      t.timestamps
    end
  end
end
