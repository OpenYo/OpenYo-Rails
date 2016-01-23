class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.integer :user_id, null: false
      t.integer :with_id, null: false

      t.timestamps null: false
    end
    add_index :friends, ["user_id", "with_id"], name: "index_friends_on_user_id_and_with_id", unique: true
  end
end
