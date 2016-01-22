class CreateYos < ActiveRecord::Migration
  def change
    create_table :yos do |t|
      t.integer :user_id
      t.integer :to_id

      t.timestamps null: false
    end
  end
end
