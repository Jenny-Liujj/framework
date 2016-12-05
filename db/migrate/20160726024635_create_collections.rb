class CreateCollections < ActiveRecord::Migration[5.0]
  def change
    create_table :collections do |t|
      t.integer :user_id
      t.integer :collectable_id
      t.string  :collectable_type
      t.integer :value, default: 0
      t.integer :abuse, default: 0

      t.timestamps
    end
  end
end
