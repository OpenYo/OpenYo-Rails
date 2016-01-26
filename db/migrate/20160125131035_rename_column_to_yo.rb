class RenameColumnToYo < ActiveRecord::Migration
  def change
    rename_column :yos, :to_id, :from_id
  end
end
