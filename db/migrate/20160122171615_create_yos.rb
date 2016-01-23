class CreateYos < ActiveRecord::Migration
  def change
    create_table :yos do |t|
      t.integer :user_id, null: false
      t.integer :to_id,   null: false

      t.timestamps null: false
    end
  end
end
