class CreateUserTest2s < ActiveRecord::Migration[5.0]
  def change
    create_table :user_test2s do |t|
      t.string :username
      t.string :password

      t.timestamps
    end
  end
end
