class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.integer :user_id
      t.integer :votable_id
      t.string  :votable_type
      t.integer :value, default: 0   # Value can be -1, 0 or 1.
      t.integer :abuse, default: 0   # Record whether user has abuse the vote system.

      t.timestamps
    end
  end
end
