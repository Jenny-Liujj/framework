class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :post_id
      t.string  :content
      t.integer :vote_count, default: 0
      t.integer :collection_count, default: 0
      t.integer :position
      t.string  :status

      t.timestamps
    end
  end
end
