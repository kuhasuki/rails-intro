class DropCount < ActiveRecord::Migration
  def change
    remove_column :visits, :count
  end
end
